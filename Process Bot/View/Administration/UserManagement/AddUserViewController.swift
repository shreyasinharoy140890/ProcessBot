//
//  AddUserViewController.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 08/09/21.
//

import UIKit
import Alamofire

class AddUserViewController: UIViewController {
    @IBOutlet weak var textfielduserName: UITextField!
    @IBOutlet weak var textfieldfullName: UITextField!
    @IBOutlet weak var textfieldemail: UITextField!
    @IBOutlet weak var textfieldrolename: UITextField!
    @IBOutlet weak var buttoncancel: UIButton!
    @IBOutlet weak var buttonsave: UIButton!
    @IBOutlet weak var buttonaddrole: UIButton!
    let token  = UserDefaults.standard.value(forKey: "TOKEN")
    let userid = UserDefaults.standard.value(forKey: "USERID")
    let clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    let roleid = UserDefaults.standard.value(forKey: "ROLEID")

    override func viewDidLoad() {
        super.viewDidLoad()
setupUI()
        // Do any additional setup after loading the view.
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

    //MARK: Button Actions
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnsave(_ sender: UIButton) {
     
        createuser()
   
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    
  //MARK: Webservice Call
    func createuser()
    {
        
        let parameters = [
            "Username":textfielduserName.text!,
            "Email":textfieldemail.text!,
             "ClientID":clientid!,
             "RoleID":roleid!,
             "CreatedBy":clientid!,
             "FullName" :textfieldfullName.text!
        ]
        print(parameters)
        let headers = [
            "AppName":"IntelgicApp",
            "Token":token!as! String,
        ]
        Alamofire.request("http://3.7.99.38:5001/api/User/CreateUser?", method:.post, parameters: parameters,encoding: JSONEncoding.default,headers: headers) .responseJSON { (response) in
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
 
  
    
    
    
    
}
