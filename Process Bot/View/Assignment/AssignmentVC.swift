//
//  AssignmentVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 15/11/21.
//

import UIKit

//
//  UserManagementViewController.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 06/09/21.
//

import UIKit

class AssignmentVC: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableusers: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    
    var viewModeluserlistDetails:UserManagementViewModelProtocol?
    var userlistdetails = [UserListModel]()
    var arrayfirstnamelist = [String]()
    var arrayusernamelist = [String]()
    var arrayemaillist = [String]()
    var arraytimelist = [String]()
    var arraydatelist = [String]()
    var arrayrolenamelist = [String]()
    var arraycreatedby = [String]()
    var arrayrole = [String]()
    var date:String?
    var time:String?
    var filtered = [UserListModel]()
    var searchText:String?
    var isFiltering = false
    var usernamestring:String?
    var fullnamestring:String?
    var emailstring:String?
    var rolename:String?
    var userid:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableusers.delegate = self
        tableusers.dataSource = self
        tableusers.register(AssignmentTableViewCell.self)
        SidePanelViewController.default.delegate = self
        setupUI()
        self.viewModeluserlistDetails = UserManagementViewModel()
        viewModeluserlistDetails?.manager = RequestManager()
        callGetuserlistDetails()
        textFieldSearch.delegate = self
        textFieldSearch.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        textFieldSearch.text = searchText
    }


    func setupUI (){
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewSearch.layer.cornerRadius = 8
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
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
   
}
extension AssignmentVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayfirstnamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: AssignmentTableViewCell.self), for: indexPath) as! AssignmentTableViewCell
        cell.labelUsername.text = arrayusernamelist[indexPath.row]
        usernamestring =  cell.labelUsername.text
        cell.labelroleName.text = arrayrolenamelist[indexPath.row]
        cell.labelEmail.text = arrayemaillist[indexPath.row]
        cell.btnshowlist.addTarget(self, action: #selector(showrobotlist), for:.touchUpInside)
        rolename = cell.labelroleName.text
        date = arraydatelist[indexPath.row]
        print(date!.stringBefore("T"))
        _ = date!.stringBefore("T")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.userlistdetails[indexPath.row].iD!)
       UserDefaults.standard.set(self.userlistdetails[indexPath.row].iD!, forKey: "USER_ID")
        UserDefaults.standard.set(self.userlistdetails[indexPath.row].adminYN!, forKey: "ADMINSTATUS")
         UIView.animate(withDuration: 0.3) {
           self.tableusers.performBatchUpdates(nil)
       
}
       
        
    }
    @objc func showrobotlist()
    {
        let VC = RobotListVC(nibName: "RobotListVC", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
extension AssignmentVC:SidePanelDelegate {
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    @objc func textFieldValueChange(_ txt: UITextField)  {
        searchText = textFieldSearch.text!
        
        if (searchText != ""){
            isFiltering = true

            filtered = userlistdetails.filter {
                $0.fullName?.range(of: searchText!, options: .caseInsensitive, range: nil, locale: nil) != nil
                        }
                        print(filtered)
            
        }else {
            isFiltering = false
            filtered = userlistdetails
        }
        self.tableusers.reloadData()
    }
    @objc func navigatetonext(_ sender:UIButton)
    {
        let cell = tableusers.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? UserManagementTableViewCell
        if (sender.isSelected){
            let VC = UpdateUserVC(nibName: "UpdateUserVC", bundle: nil)
            UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)
            VC.fullnamestring = arrayfirstnamelist[sender.tag]
            VC.usernamestring = arrayfirstnamelist[sender.tag]
            VC.emailstring = arrayemaillist[sender.tag]
            VC.rolename = arrayrolenamelist[sender.tag]
            VC.createdby = arraycreatedby[sender.tag]
        }else {
           
            sender.isSelected = true
        
        }
     
    }
}
extension AssignmentVC:AlertDisplayer
{
//MARK:- Webservice Call
    func callGetuserlistDetails(){
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModeluserlistDetails?.getUsersList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        userlistdetails = viewModeluserlistDetails!.usersdetails
                        print(userlistdetails)
                        for i in 0..<userlistdetails.count
                        {
                            print(userlistdetails[i].username!)
                            arrayfirstnamelist.append(userlistdetails[i].fullName!)
                            arrayusernamelist.append(userlistdetails[i].username!)
                            arrayemaillist.append(userlistdetails[i].email!)
                            arraydatelist.append(userlistdetails[i].createDate!)
                            
                            arraytimelist.append(userlistdetails[i].lastSuccessfulLogin!)
                            arraycreatedby.append(userlistdetails[i].createdBy!)
                            
                            
                            time = userlistdetails[i].lastSuccessfulLogin!
                            if let rolename = userlistdetails[i].roleName {
                                print("No")
                                arrayrolenamelist.append(userlistdetails[i].roleName!)
                            } else {
                               print("Yes")
                                arrayrolenamelist.append("Not Applicable")
                            }
                           
                            UserDefaults.standard.set(self.userlistdetails[i].username!, forKey: "USERNAME")
                            
                            UserDefaults.standard.set(self.userlistdetails[i].roleID!, forKey: "USERROLEID")
                            
                           
                         
                        }
                        self.tableusers.reloadData()
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
