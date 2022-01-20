//
//  RoleUpdateVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 28/09/21.
//

import UIKit
import Alamofire

class RoleUpdateVC: UIViewController,AlertDisplayer, SidePanelDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var textfieldrolename: UITextField!
    @IBOutlet weak var textfieldroledescription: UITextField!
    @IBOutlet weak var viewroleList: UIView!
    @IBOutlet weak var tablerolelist: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonSave: UIButton!
    
    var viewModelpermissionlistDetails:PermissionViewModelProtocol?
    var permissionlistdetails = [PermissionListModel]()
    var myNewDictArray: [Dictionary<String, AnyObject>] = []
    var permissionlist = [Any]()
    var componentName:String?
    var componentID:Int?
    var roleNameString:String?
    var roleid:Int?
    var roledescription:String?
    var isedit:Bool?
    var isView:Bool?
    var isDelete:Bool?
    var isAdd:Bool?
    var componentcode:String?
    var arraycomponentName = [String]()
    var arraycomponentId = [Int]()
    var arraycomponentCode = [String]()
    var arrayisAdd = [Bool]()
    var arrayisView = [Bool]()
    var arrayisDelete = [Bool]()
    var checked = false
    var token  = UserDefaults.standard.value(forKey: "TOKEN")
    
    var clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.viewModelpermissionlistDetails = PermissionViewModel()
        viewModelpermissionlistDetails?.manager = RequestManager()
        getpermissionlist()
        //  getallpermissions()
        textfieldrolename.text = roleNameString
        textfieldroledescription.text = roledescription
        tablerolelist.delegate = self
        tablerolelist.dataSource = self
        tablerolelist.register(RoleUpdateTableViewCell.self)
        SidePanelViewController.default.delegate = self
        scrollView.delegate = self
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
        // permissionlist.removeAll()
        
    }
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    func setupUI (){
        
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewMain.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewroleList.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
        textfieldrolename.layer.borderWidth = 2
        textfieldrolename.layer.borderColor = UIColor.lightGray.cgColor
        textfieldrolename.layer.cornerRadius = 8
        textfieldrolename.isUserInteractionEnabled = false
        
        
        textfieldroledescription.layer.borderWidth = 2
        textfieldroledescription.layer.borderColor = UIColor.lightGray.cgColor
        textfieldroledescription.layer.cornerRadius = 8
        textfieldroledescription.isUserInteractionEnabled = false
        
    }
    
    //MARK: ScrollView Delegate Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = Float(scrollView.frame.size.height)
        let scrollContentSizeHeight = Float(scrollView.contentSize.height)
        let scrollOffset = Float(scrollView.contentOffset.y)
        
        if scrollOffset + scrollViewHeight == scrollContentSizeHeight {
            
        }
    }
    
    
    //MARK: Webservice Call
    func getpermissionlist()
    {
        
        DispatchQueue.main.async {
            
        }
        viewModelpermissionlistDetails?.getPermissionList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        permissionlistdetails =   viewModelpermissionlistDetails!.permissionlist
                        print(permissionlistdetails)
                        let array = permissionlistdetails as NSArray
                        print(array)
                        
                        for i in 0..<permissionlistdetails.count
                        {
                            arraycomponentName.append(permissionlistdetails[i].componentName!)
                            arraycomponentId.append(permissionlistdetails[i].componentID!)
                            arraycomponentCode.append(permissionlistdetails[i].componentCode!)
                            arrayisAdd.append(permissionlistdetails[i].isAdd!)
                            arrayisView.append(permissionlistdetails[i].isView!)
                            arrayisDelete.append(permissionlistdetails[i].isDelete!)
                            
                        }
                        
                        tablerolelist.reloadData()
                        
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
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSave(_sender:UIButton)
    {
       
        var permissionArray = [RolePermissionList]()
        
        for each in permissionlistdetails{
            let eachValue = RolePermissionList(ComponentID: each.componentID!, ComponentCode: each.componentCode!, ComponentName: each.componentName!, IsView: each.isView!, IsAdd: each.isAdd!, IsEdit: each.isEdit!, IsDelete: each.isDelete!)
            permissionArray.append(eachValue)
        }
       let requestBody = RoleUpdate(RoleID: "\(roleid!)", ClientID: clientid! as! String, RoleName: roleNameString!, RoleDescription: roledescription!, Permission: permissionArray)
        
        
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
        
     let Url = String(format: "http://3.7.99.38:5001/api/User/AddUpdateRoles")
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
            if dataString == "\"Updated\""
            {
            let alertController = UIAlertController(title: "", message: "Role Updated", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                let VC = RoleManagementVC(nibName: "RoleManagementVC", bundle: nil)
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


}


//MARK: Tableview datasource and delegate

extension RoleUpdateVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraycomponentName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: RoleUpdateTableViewCell.self), for: indexPath) as! RoleUpdateTableViewCell
        cell.labelroleName.text = arraycomponentName[indexPath.row]
        isView = arrayisView[indexPath.row]
        print(isView)
        if isView == true
        {
            if let image = UIImage(named: "check_tick.png") {
                cell.buttonView.setImage(image, for: .normal)
                checked = true
            }
        }
        else
        {
            if let image = UIImage(named: "check_untick.png") {
                cell.buttonView.setImage(image, for: .normal)
                checked = false
            }
        }
        isAdd = arrayisAdd[indexPath.row]
        if isAdd == true
        {
            if let image = UIImage(named: "check_tick.png") {
                cell.buttonAdd.setImage(image, for: .normal)
                checked = true
            }
        }
        else
        {
            if let image = UIImage(named: "check_untick.png") {
                cell.buttonAdd.setImage(image, for: .normal)
                checked = false
            }
        }
        isedit = arrayisAdd[indexPath.row]
        if isedit == true
        {
            if let image = UIImage(named: "check_tick.png") {
                cell.buttonAdd.setImage(image, for: .normal)
                checked = true
            }
        }
        else
        {
            if let image = UIImage(named: "check_untick.png") {
                cell.buttonAdd.setImage(image, for: .normal)
                checked = false
            }
        }
        isDelete = arrayisDelete[indexPath.row]
        if isDelete == true
        {
            if let image = UIImage(named: "check_tick.png") {
                cell.buttonDelete.setImage(image, for: .normal)
                checked = true
            }
        }
        else
        {
            if let image = UIImage(named: "check_untick.png") {
                cell.buttonDelete.setImage(image, for: .normal)
                checked = false
            }
        }
        
        cell.buttonAdd.addTarget(self, action: #selector(handleAdd), for:.touchUpInside)
        cell.buttonView.addTarget(self, action: #selector(handleView), for:.touchUpInside)
        cell.buttonDelete.addTarget(self, action: #selector(handleDelete), for:.touchUpInside)
        
        cell.cellSetup(index: indexPath.row)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func handleAdd(sender:UIButton)
    {
        let buttonPosition:CGPoint = sender.convert(.zero, to:tablerolelist)
        let indexPath = tablerolelist.indexPathForRow(at: buttonPosition)
        
        
        if (permissionlistdetails[indexPath!.row].isAdd! == true)
        {
          
            permissionlistdetails[indexPath!.row].isAdd! = false
            let image = UIImage(named: "check_untick.png")
            sender.setImage(image, for:.normal)
            print(permissionlistdetails)
        }
        else
        {
            permissionlistdetails[indexPath!.row].isAdd! = true
            let image = UIImage(named: "check_tick.png")
            sender.setImage(image, for:.normal)
            print(permissionlistdetails)
        }
        
        
    }
    
    @objc func handleView(sender:UIButton)
    {
        let buttonPosition:CGPoint = sender.convert(.zero, to:tablerolelist)
        let indexPath = tablerolelist.indexPathForRow(at: buttonPosition)
        
        
        if (permissionlistdetails[indexPath!.row].isView! == true)
        {
            permissionlistdetails[indexPath!.row].isView! = false
            let image = UIImage(named: "check_untick.png")
            sender.setImage(image, for:.normal)
            print(permissionlistdetails)
        }
        else
        {
            permissionlistdetails[indexPath!.row].isView! = true
            let image = UIImage(named: "check_tick.png")
            sender.setImage(image, for:.normal)
            print(permissionlistdetails)
        }
        
        
    }
    @objc func handleDelete(sender:UIButton)
    {
        let buttonPosition:CGPoint = sender.convert(.zero, to:tablerolelist)
        let indexPath = tablerolelist.indexPathForRow(at: buttonPosition)
        
        
        if (permissionlistdetails[indexPath!.row].isDelete! == true)
        {
            permissionlistdetails[indexPath!.row].isDelete! = false
            let image = UIImage(named: "check_untick.png")
            sender.setImage(image, for:.normal)
            print(permissionlistdetails)
        }
        else
        {
            permissionlistdetails[indexPath!.row].isDelete! = true
            let image = UIImage(named: "check_tick.png")
            sender.setImage(image, for:.normal)
            print(permissionlistdetails)
        }
        
        
    }
    
}
extension NSArray {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
