//
//  UpdateUserVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 07/09/21.
//

import UIKit

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
    var rolename:String?
    var viewModelroleslistDetails:UserManagementViewModelProtocol?
    var rolelistdetails = [RoleListModel]()
    var arrayrolenamelist = [String]()
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedbutton = UIButton()
    var datasource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        textfielduserName.text = usernamestring
        textfieldfullName.text = fullnamestring
        textfieldemail.text = emailstring
        self.viewModelroleslistDetails = UserManagementViewModel()
        viewModelroleslistDetails?.manager = RequestManager()
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
        
        textfieldfullName.layer.borderWidth = 2
        textfieldfullName.layer.borderColor = UIColor.lightGray.cgColor
        textfieldfullName.layer.cornerRadius = 8
        textfieldfullName.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
        textfieldemail.layer.borderWidth = 2
        textfieldemail.layer.borderColor = UIColor.lightGray.cgColor
        textfieldemail.layer.cornerRadius = 8
        textfieldemail.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
        textfieldrolename.layer.borderWidth = 2
        textfieldrolename.layer.borderColor = UIColor.lightGray.cgColor
        textfieldrolename.layer.cornerRadius = 8
        textfieldrolename.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
        
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
        removeTransparentView()
    }
  
    }
   

