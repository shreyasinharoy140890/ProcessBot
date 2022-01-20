//
//  UpdateDirectoryVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 11/11/21.
//

import UIKit
import Alamofire
class UpdateDirectoryVC: UIViewController {
    @IBOutlet weak var textfielddirectoryname: UITextField!
    @IBOutlet weak var textfieldirectorydescription: UITextView!
    var userid = UserDefaults.standard.value(forKey: "USER_ID")
    var clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    let token  = UserDefaults.standard.value(forKey: "TOKEN")
    var directoryid = UserDefaults.standard.value(forKey: "DIRECTORY_ID")
    var directoryname:String?
    var directorydescription:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textfielddirectoryname.layer.borderWidth = 2
        textfielddirectoryname.layer.borderColor = UIColor.lightGray.cgColor
        textfielddirectoryname.layer.cornerRadius = 8
        textfielddirectoryname.text! = directoryname!
       
        textfieldirectorydescription.layer.borderWidth = 2
        textfieldirectorydescription.layer.borderColor = UIColor.lightGray.cgColor
        textfieldirectorydescription.layer.cornerRadius = 8
        textfieldirectorydescription.text! = directorydescription!
     
        
    }
    //MARK: - Button Actions
    @IBAction func btndismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let VC = DirectoryVC(nibName: "DirectoryVC", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnsave(_ sender: Any) {
        updatedirectory()
    }
    //MARK: Webservice Call
      func updatedirectory()
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
            "DirectoryID": directoryid!,
            "ClientID": clientid!,
            "DirectoryName":textfielddirectoryname.text!,
            "Description": textfieldirectorydescription.text!,
            
                    
          ] as [String : Any]
          print(parameters)
          let headers = [
              "AppName":"IntelgicApp",
              "Token":token!as! String,
          ]
          Alamofire.request("http://3.7.99.38:5001/api/User/AddUpdateDirectory", method:.post, parameters: parameters,encoding: JSONEncoding.default,headers: headers) .responseJSON { (response) in
              print(response.description)
             
              // Create the alert controller
                  let alertController = UIAlertController(title: "", message: "Directory Updated", preferredStyle: .alert)

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
