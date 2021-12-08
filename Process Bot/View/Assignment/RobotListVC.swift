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
    
    var directoryname:String?
    var directoryid:Int?
    var arraydirectorynamelist = [String]()
    var arraydirectorydescriptionlist = [String]()
    let chooseDirectoryDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.chooseDirectoryDropDown,
           
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
       
//        tablerobotlist.delegate = self
//        tablerobotlist.dataSource = self
//        tablerobotlist.register(RoleUpdateTableViewCell.self)
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
        
        getdirectorylist()
        getcurrentdirectory()
        getassignmentlist()
        
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
                        print(assignmentlistdetails)
                        tablerobotlist.reloadData()
                        
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
        if let image = UIImage(named: "check_untick.png") {
            cell.buttonselect.setImage(image, for: .normal)
        }
        return cell
    }
    
}
