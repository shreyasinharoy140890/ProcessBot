//
//  AddDirectoryVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 10/11/21.
//

import UIKit
import Alamofire

class AddDirectoryVC: UIViewController {
    @IBOutlet weak var textfielddirectoryname: UITextField!
    @IBOutlet weak var textfieldirectorydescription: UITextField!
    var userid = UserDefaults.standard.value(forKey: "USERID")
    var clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    let token  = UserDefaults.standard.value(forKey: "TOKEN")
    override func viewDidLoad() {
        super.viewDidLoad()
        textfielddirectoryname.layer.borderWidth = 2
        textfielddirectoryname.layer.borderColor = UIColor.lightGray.cgColor
        textfielddirectoryname.layer.cornerRadius = 8
       
        
        
        textfieldirectorydescription.layer.borderWidth = 2
        textfieldirectorydescription.layer.borderColor = UIColor.lightGray.cgColor
        textfieldirectorydescription.layer.cornerRadius = 8
     
        // Do any additional setup after loading the view.
    }
    
//MARK: - Button Actions
    @IBAction func btndismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       
    }
    @IBAction func btnadd(_ sender: Any) {
        createdirectory()
    }
    //MARK: Webservice Call
      func createdirectory()
      {
        if textfielddirectoryname.text! == ""
        {
            // Create the alert controller
                let alertController = UIAlertController(title: "", message: "Please specify name of the directory", preferredStyle: .alert)

                // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
              
                }
            
                // Add the actions
                alertController.addAction(okAction)
              

                // Present the controller
                self.present(alertController, animated: true, completion: nil)
        }
        
        else  if textfieldirectorydescription.text! == ""
        {
            // Create the alert controller
                let alertController = UIAlertController(title: "", message: "Please specify description of the directory", preferredStyle: .alert)

                // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
              
                }
            
                // Add the actions
                alertController.addAction(okAction)
              

                // Present the controller
                self.present(alertController, animated: true, completion: nil)
        }
        else
        {
          let parameters = [
            "ClientID":clientid!,
            "DirectoryName":textfielddirectoryname.text!,
            "Description":textfieldirectorydescription.text!,
            "OwnerID":userid!
          ]
          print(parameters)
          let headers = [
              "AppName":"IntelgicApp",
              "Token":token!as! String,
          ]
          Alamofire.request("http://3.7.99.38:5001/api/User/AddUpdateDirectory", method:.post, parameters: parameters,encoding: JSONEncoding.default,headers: headers) .responseJSON { (response) in
              print(response.description)
             
              // Create the alert controller
                  let alertController = UIAlertController(title: "", message: "Directory Created", preferredStyle: .alert)

                  // Create the actions
              let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                      UIAlertAction in
                      NSLog("OK Pressed")
                
                  }
              
                  // Add the actions
                  alertController.addAction(okAction)
                

                  // Present the controller
                  self.present(alertController, animated: true, completion: nil)
             }
      }
    
      }
}
