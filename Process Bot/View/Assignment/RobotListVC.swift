//
//  RobotListVC.swift
//  Process Bot
//
//  Created by Appsbee on 07/12/21.
//

import UIKit
import DropDown
class RobotListVC: UIViewController,AlertDisplayer {
   
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnDirectory: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewrobotList: UIView!
    @IBOutlet weak var tablerobotlist: UITableView!
    @IBOutlet weak var chooseDirectory: UIView!
    @IBOutlet weak var lbldirectoryname: UILabel!
    
    var viewModeldirectorylistDetails:DirectoryViewModelProtocol?
    var directorylistdetails = [DirectoryModel]()
    var viewModelcurrentDirectory:DirectoryViewModelProtocol?
    var currentdirectory = [CurrentDirectoryModel]()
    var viewModelassignmentlist:AssignmentListViewModelProtocol?
    var assignmentlistdetails = [AssignmentListModel]()
    var arrayisSelected = [Bool]()
    var directoryname:String?
    var directoryid:Int?
    var arraydirectorynamelist = [String]()
    var arraydirectorydescriptionlist = [String]()
    let chooseDirectoryDropDown = DropDown()
    
    var token  = UserDefaults.standard.value(forKey: "TOKEN")
    var clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    var userid = UserDefaults.standard.value(forKey: "USERID")
    
    
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.chooseDirectoryDropDown,
           
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
 
        self.viewModeldirectorylistDetails = DirectoryViewModel()
        viewModeldirectorylistDetails?.manager = RequestManager()
        self.viewModelcurrentDirectory = DirectoryViewModel()
        viewModelcurrentDirectory?.manager = RequestManager()
        self.viewModelassignmentlist = AssignmentListViewModel()
        viewModelassignmentlist?.manager = RequestManager()
      
        dropDowns.forEach { $0.dismissMode = .automatic }
        dropDowns.forEach { $0.direction = .bottom }
        chooseDirectory.layer.cornerRadius = 8;
        chooseDirectory.clipsToBounds = true;
        chooseDirectory.layer.borderWidth = 1;
        chooseDirectory.layer.borderColor = UIColor.systemBlue.cgColor
        
        getcurrentdirectory()
        getassignmentlist()
        getdirectorylist()
       
        
        tablerobotlist.delegate = self
        tablerobotlist.dataSource = self
        tablerobotlist.register(RobotListTableViewCell.self)
       
    }


    func setupUI (){
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewSearch.layer.cornerRadius = 8
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewMain.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewrobotList.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    }
    
    //MARK:- Button Actions
       @IBAction func btnMenuAction(_ sender: UIButton) {
           if sender.isSelected {
               SidePanelViewController.default.hide()
               sender.isSelected = false
           }
           else {
               SidePanelViewController.default.show(on: self)
               sender.isSelected = true
           }
       }
    
    @IBAction func btnshowdirectory(_ sender: UIButton) {
        setupChooseArticleDropDown()
        chooseDirectoryDropDown.show()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSave(_sender:UIButton)
    {
       
        var assignmentArray = [AssignmentList]()
        
        for each in assignmentlistdetails{
            let eachValue = AssignmentList(AssignedID: each.assignedID!, PublishedScriptID: each.publishedScriptID!, AssignedToUserID: each.assignedToUserID!,Enabled:each.enabled! )
            assignmentArray.append(eachValue)
        }
       let requestBody = AssignmentUpdate( ClientID: clientid! as! String, AssignedByUserID:userid! as! String, AssignedList: assignmentArray)
        
        
        let jsonEncoder = JSONEncoder()
        var encodedData: Data?
        do{
            
            encodedData = try! jsonEncoder.encode(requestBody)
          //  print(data)
            let str = String(decoding: encodedData!, as: UTF8.self)
            print("Strung value is \(str)")
        }
        
        catch{
            
        }
        
     let Url = String(format: "http://3.7.99.38:5001/api/User/AddAssignment")
            guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
        request.addValue("IntelgicApp", forHTTPHeaderField: "AppName")
        request.addValue(token! as! String, forHTTPHeaderField: "Token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpBody = encodedData
            
            let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            print(response?.description)
            guard error == nil else{
                print("error after network call \(error?.localizedDescription)")
                return
            }
            
            
            let dataString = String(decoding: data!, as: UTF8.self)
            print("data string \(dataString)")
            DispatchQueue.main.async {
            if dataString == "\"Saved\""
            {
            let alertController = UIAlertController(title: "", message: "Assigned List Updated", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                let VC = AssignmentVC(nibName: "AssignmentVC", bundle: nil)
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
            // Add the actions
            alertController.addAction(okAction)
            
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
                   
       }
    
        print(response?.description)
        }.resume()
        
        
        
    
}

    
    
    
    
    //MARK:- Webservice Call
    func setupChooseArticleDropDown() {
       
        chooseDirectoryDropDown.anchorView = btnDirectory
        chooseDirectoryDropDown.bottomOffset = CGPoint(x: 0, y: chooseDirectory.bounds.height)
        print(arraydirectorynamelist)
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseDirectoryDropDown.dataSource = arraydirectorynamelist
        
        // Action triggered on selection
        chooseDirectoryDropDown.selectionAction = { [weak self] (index, item) in
            self?.lbldirectoryname.text = item
            self?.directoryname =  self?.lbldirectoryname.text
            self?.directoryid = self?.directorylistdetails[index].directoryID
            print(self?.directoryid!)
            self?.getassignmentlist()
            UserDefaults.standard.set(self?.directoryid, forKey: "DIRECTORYID")
            self?.chooseDirectoryDropDown.hide()
           
        }
        
        chooseDirectoryDropDown.multiSelectionAction = { [weak self] (indices, items) in
            print("Muti selection action called with: \(items)")
            self?.chooseDirectoryDropDown.hide()
            if items.isEmpty {
                self?.lbldirectoryname.text = ""
          //      self?.chooseDirectory.setTitle("", for: .normal)
            }
        }
        
      
    }
    func getdirectorylist()
    {
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModeldirectorylistDetails?.getDirectoryList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        directorylistdetails =   viewModeldirectorylistDetails!.directorylist
                        print(directorylistdetails)
                        for i in 0..<directorylistdetails.count
                        {
                        arraydirectorynamelist.append(directorylistdetails[i].directoryName!)
        
                    }
                        print(arraydirectorynamelist)
                }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
    
    func getcurrentdirectory()
    {
        
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModelcurrentDirectory?.getCurrentDirectory(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        currentdirectory =   viewModelcurrentDirectory!.currentdirectory
                        print(currentdirectory)
                        for i in 0..<currentdirectory.count
                        {
                            directoryname = currentdirectory[i].directoryName
                            lbldirectoryname.text = directoryname
                            directoryid = currentdirectory[i].directoryID
                            UserDefaults.standard.set(directoryid, forKey: "DIRECTORYID")
                        
                    }
                        getassignmentlist()
                        self.tablerobotlist.reloadData()
                }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
    
    func getassignmentlist()
    {
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModelassignmentlist?.getassignmentList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        assignmentlistdetails = viewModelassignmentlist!.assignmentlist
                        tablerobotlist.reloadData()
                        for i in 0..<assignmentlistdetails.count
                        {
                            arrayisSelected.append(assignmentlistdetails[i].enabled!)
                        }
                        print(arrayisSelected)
                       
                        
                }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
    
}
extension RobotListVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assignmentlistdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: RobotListTableViewCell.self), for: indexPath) as! RobotListTableViewCell
        cell.cellSetup(index: indexPath.row)
        cell.labelrobotName.text = assignmentlistdetails[indexPath.row].robotName
        cell.labelversionName.text = assignmentlistdetails[indexPath.row].version
        let isSelected = arrayisSelected[indexPath.row]
        if isSelected == true
        {
            if let image = UIImage(named: "check_tick.png") {
                cell.buttonselect.setImage(image, for: .normal)
            }
        }
        else
        {
            if let image = UIImage(named: "check_untick.png") {
                cell.buttonselect.setImage(image, for: .normal)
            }
        }
        cell.buttonselect.addTarget(self, action:#selector(handleSelect), for: .touchUpInside)
        return cell
    }
  
    @objc func handleSelect(sender:UIButton)
    {
        let buttonPosition:CGPoint = sender.convert(.zero, to:tablerobotlist)
        let indexPath = tablerobotlist.indexPathForRow(at: buttonPosition)
        
        
        if (assignmentlistdetails[indexPath!.row].enabled! == true)
        {
          
            assignmentlistdetails[indexPath!.row].enabled! = false
            let image = UIImage(named: "check_untick.png")
            sender.setImage(image, for:.normal)
            print(assignmentlistdetails)
        }
        else
        {
            assignmentlistdetails[indexPath!.row].enabled! = true
            let image = UIImage(named: "check_tick.png")
            sender.setImage(image, for:.normal)
            print(assignmentlistdetails)
        }
        
        
    }
}
