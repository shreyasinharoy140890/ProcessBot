//
//  UpdateUserVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 07/09/21.
//

import UIKit
import Alamofire

class CellClass:UITableViewCell
{
    
}

class UpdateUserVC: UIViewController,AlertDisplayer, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var textfielduserName: UITextField!
    @IBOutlet weak var textfieldfullName: UITextField!
    @IBOutlet weak var textfieldemail: UITextField!
    @IBOutlet weak var textfieldrolename: UITextField!
    @IBOutlet weak var buttoncancel: UIButton!
    @IBOutlet weak var buttonsave: UIButton!
    @IBOutlet weak var buttonaddrole: UIButton!
    var usernamestring:String?
    var fullnamestring:String?
    var emailstring:String?
    var roleidupdated:Int?
    var rolename:String?
    var createdby:String?
    var componentcodeString:String?
    var componentIDString:Int?
    var componentNameString:String?
    var isedit:Bool?
    var isView:Bool?
    var isDelete:Bool?
    var isAdd:Bool?
    var roledescription:String?
    var viewModelroleslistDetails:UserManagementViewModelProtocol?
    var rolelistdetails = [RoleListModel]()
    var viewModelpermissionlistDetails:PermissionViewModelProtocol?
    var permissionlistdetails = [PermissionListModel]()
    var arrayrolenamelist = [String]()
    var arrayiseditable = [Bool]()
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedbutton = UIButton()
    var datasource = [String]()
    let token  = UserDefaults.standard.value(forKey: "TOKEN")
    let userid = UserDefaults.standard.value(forKey: "USERID")
    let clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    let roleid = UserDefaults.standard.value(forKey: "ROLEID")
    let userroleid = UserDefaults.standard.value(forKey: "USERROLEID")
    let componentcode = "UMGMT"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        textfielduserName.text = usernamestring
        textfieldfullName.text = fullnamestring
        textfieldemail.text = emailstring
        if rolename == "Not Applicable"
        {
            buttonaddrole.isEnabled = false
            textfieldrolename.text = "Not allowed to change roles"
        }
       else
        {

            buttonaddrole.isEnabled = true
            textfieldrolename.text = rolename
        }
        print(rolename)
        print(usernamestring)
        print(emailstring)
        self.viewModelroleslistDetails = UserManagementViewModel()
        viewModelroleslistDetails?.manager = RequestManager()
        self.viewModelpermissionlistDetails = PermissionViewModel()
        viewModelpermissionlistDetails?.manager = RequestManager()
        getrolelist()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellClass.self,forCellReuseIdentifier:"Cell")
    }
    
    
    func addtransparentView(frames:CGRect)
    {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tapgesture = UITapGestureRecognizer(target: self, action:#selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options:.curveEaseInOut, animations: {self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: self.textfieldrolename.frame.origin.x, y: frames.origin.y + frames.height, width: 380, height: 200)
        }, completion: nil)
    }
    
    
    @objc func removeTransparentView()
    {
        let frames = textfieldrolename.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options:.curveEaseInOut, animations: {self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: 380, height: 0)
        }, completion: nil)
    }
  
    func setupUI (){
        textfielduserName.layer.borderWidth = 2
        textfielduserName.layer.borderColor = UIColor.lightGray.cgColor
        textfielduserName.layer.cornerRadius = 8
        textfielduserName.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        textfielduserName.isUserInteractionEnabled = false
        
        textfieldfullName.layer.borderWidth = 2
        textfieldfullName.layer.borderColor = UIColor.lightGray.cgColor
        textfieldfullName.layer.cornerRadius = 8
        textfieldfullName.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
        textfieldemail.layer.borderWidth = 2
        textfieldemail.layer.borderColor = UIColor.lightGray.cgColor
        textfieldemail.layer.cornerRadius = 8
        textfieldemail.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        textfieldemail.isUserInteractionEnabled = false
        
        textfieldrolename.layer.borderWidth = 2
        textfieldrolename.layer.borderColor = UIColor.lightGray.cgColor
        textfieldrolename.layer.cornerRadius = 8
        textfieldrolename.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        textfieldrolename.isUserInteractionEnabled = false
        
        buttoncancel.layer.borderWidth = 2
        buttoncancel.layer.borderColor = UIColor.systemBlue.cgColor
        buttoncancel.layer.cornerRadius = 15
        
       
        buttonsave.layer.cornerRadius = 15
    
    }
    
     
  //MARK:- Button actions
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnaddrole(_ sender: Any) {
        datasource = arrayrolenamelist
        selectedbutton = buttonaddrole!
        addtransparentView(frames:buttonaddrole.frame)
    }
    @IBAction func btnsave(_ sender: UIButton) {
     
        updateuser()
   
    }
   
    //MARK:- Webservice Call
        
        func getrolelist()
        {
            DispatchQueue.main.async {
                //   showActivityIndicator(viewController: self)
            }
            viewModelroleslistDetails?.getRolesList(completion: { result in
                switch result {
                case .success(let result):
                    if let success = result as? Bool , success == true {
                        DispatchQueue.main.async { [self] in
                            
                         rolelistdetails =   viewModelroleslistDetails!.roleslist
                            print(rolelistdetails)
                            for i in 0..<rolelistdetails.count
                            {
                                arrayrolenamelist.append(rolelistdetails[i].roleName!)
                                rolename = rolelistdetails[i].roleName!
                              
                                UserDefaults.standard.set(self.rolelistdetails[i].roleID!, forKey: "ROLEID")
                              
                    }
                            getpermissionlist()
                           
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
    
    func getpermissionlist()
    {
       
       DispatchQueue.main.async {
           //   showActivityIndicator(viewController: self)
       }
       viewModelpermissionlistDetails?.getPermissionList(completion: { result in
           switch result {
           case .success(let result):
               if let success = result as? Bool , success == true {
                   DispatchQueue.main.async { [self] in
                       
                    permissionlistdetails =   viewModelpermissionlistDetails!.permissionlist
                    print(permissionlistdetails)
                       for i in 0..<permissionlistdetails.count
                       {
                        if permissionlistdetails[i].componentCode == componentcode
                        {
                             componentcodeString = permissionlistdetails[i].componentCode
                            componentIDString = permissionlistdetails[i].componentID
                            componentNameString = permissionlistdetails[i].componentName
                            isView = permissionlistdetails[i].isView
                            isedit = permissionlistdetails[i].isEdit
                            isAdd = permissionlistdetails[i].isAdd
                            isDelete = permissionlistdetails[i].isDelete
                        }
                          
                          
               }
                    print(componentcodeString!)
                    print(componentIDString!)
                    print(componentNameString!)
                    
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
       
 
    
    func updateuser()
    {
        if buttonaddrole.isSelected == true
        {
            roleidupdated = 0
        }
        else
        {
            roleidupdated = roleid! as! Int
        }
        
        let parameters = [
            "UserID": userid!,
            "ClientID":clientid!,
            "FullName": textfieldfullName.text!,
            "RoleID": roleidupdated!,
            "ActiveYN": "Y"
        ]
        let headers = [
            "AppName":"IntelgicApp",
            "Token":token!as! String,
        ]
        Alamofire.request("http://3.7.99.38:5001/api/User/UpdateUser?", method:.post, parameters: parameters,encoding: JSONEncoding.default,headers: headers) .responseJSON { (response) in
               print(response)
            // Create the alert controller
                let alertController = UIAlertController(title: "", message: "Profile Updated", preferredStyle: .alert)

                // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                let VC = UserManagementViewController(nibName: "UserManagementViewController", bundle: nil)
                self.navigationController?.pushViewController(VC, animated: true)
                }
            
                // Add the actions
                alertController.addAction(okAction)
              

                // Present the controller
                self.present(alertController, animated: true, completion: nil)
           }
    }
 
  
 //MARK: TableView datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell",for: indexPath)
        cell.textLabel?.text = datasource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        textfieldrolename.text =  datasource[indexPath.row]
        roledescription = arrayrolenamelist[indexPath.row].description
        removeTransparentView()
    }
  
    }
   

