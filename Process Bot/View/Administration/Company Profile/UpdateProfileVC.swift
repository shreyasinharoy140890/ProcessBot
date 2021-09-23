//
//  UpdateProfileVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 22/09/21.
//

import UIKit
import DropDown
import Alamofire

class UpdateProfileVC: UIViewController,AlertDisplayer,UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var phoneNumbertextfield: UITextField!
    
    @IBOutlet weak var departmentTextfield: UITextField!
    
    @IBOutlet weak var designationTextField: UITextField!
    
    @IBOutlet weak var companynameTextField: UITextField!
    
    @IBOutlet weak var industryTextField: UITextField!
    
    @IBOutlet weak var timezoneTextField: UITextField!
    @IBOutlet weak var buttoncancel: UIButton!
    @IBOutlet weak var buttonsave: UIButton!
    @IBOutlet weak var buttonaddrole: UIButton!
    var viewModeltimezonelistDetails:CompanyProfileViewModel?
    var timezonelistdetails = [TimeZoneModel]()
    var token  = UserDefaults.standard.value(forKey: "TOKEN")
    var clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    var customerid = UserDefaults.standard.value(forKey: "CUSTOMERID")
    var email:String?
    var phone:String?
    var department:String?
    var designation:String?
    var companyname:String?
    var industry:String?
    var timeZone:String?
    var arraytimezones = [String]()
    let dropDown = DropDown()
    var timezoneID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModeltimezonelistDetails = CompanyProfileViewModel()
        viewModeltimezonelistDetails?.manager = RequestManager()
        scrollView.delegate = self
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
        setupUI()
        buttoncancel.layer.borderWidth = 2
        buttoncancel.layer.borderColor = UIColor.systemBlue.cgColor
        buttoncancel.layer.cornerRadius = 15
        
       
        buttonsave.layer.cornerRadius = 15
        
        emailTextfield.text = email
        phoneNumbertextfield.text = phone
        departmentTextfield.text = department
        designationTextField.text = designation
        companynameTextField.text = companyname
        industryTextField.text = industry
        timezoneTextField.text = timeZone
        
        gettimezonelist()
    }
    
  func setupUI()
  {
    emailTextfield.layer.borderWidth = 2
    emailTextfield.layer.borderColor = UIColor.lightGray.cgColor
    emailTextfield.layer.cornerRadius = 8
    emailTextfield.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    emailTextfield.isUserInteractionEnabled = true
    
    phoneNumbertextfield.layer.borderWidth = 2
    phoneNumbertextfield.layer.borderColor = UIColor.lightGray.cgColor
    phoneNumbertextfield.layer.cornerRadius = 8
    phoneNumbertextfield.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    phoneNumbertextfield.isUserInteractionEnabled = true
    
    phoneNumbertextfield.layer.borderWidth = 2
    phoneNumbertextfield.layer.borderColor = UIColor.lightGray.cgColor
    phoneNumbertextfield.layer.cornerRadius = 8
    phoneNumbertextfield.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    phoneNumbertextfield.isUserInteractionEnabled = true
    
    departmentTextfield.layer.borderWidth = 2
    departmentTextfield.layer.borderColor = UIColor.lightGray.cgColor
    departmentTextfield.layer.cornerRadius = 8
    departmentTextfield.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    departmentTextfield.isUserInteractionEnabled = true
    
    designationTextField.layer.borderWidth = 2
    designationTextField.layer.borderColor = UIColor.lightGray.cgColor
    designationTextField.layer.cornerRadius = 8
    designationTextField.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    designationTextField.isUserInteractionEnabled = true
    
    companynameTextField.layer.borderWidth = 2
    companynameTextField.layer.borderColor = UIColor.lightGray.cgColor
    companynameTextField.layer.cornerRadius = 8
    companynameTextField.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    companynameTextField.isUserInteractionEnabled = true
    
    industryTextField.layer.borderWidth = 2
    industryTextField.layer.borderColor = UIColor.lightGray.cgColor
    industryTextField.layer.cornerRadius = 8
    industryTextField.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    industryTextField.isUserInteractionEnabled = true
    
    timezoneTextField.layer.borderWidth = 2
    timezoneTextField.layer.borderColor = UIColor.lightGray.cgColor
    timezoneTextField.layer.cornerRadius = 8
    timezoneTextField.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    timezoneTextField.isUserInteractionEnabled = true
    
    
  }
    //MARK:- Button actions
      @IBAction func btnBack(_ sender: Any) {
          self.navigationController?.popViewController(animated: true)
      }
    @IBAction func btnaddrole(_ sender: Any) {
        dropDown.dataSource = arraytimezones
        dropDown.direction = .top
        dropDown.bottomOffset = CGPoint(x: 0, y: buttonaddrole.bounds.height)
        dropDown.anchorView = buttonaddrole
        dropDown.width = timezoneTextField.frame.size.width
        dropDown.selectionAction = { [weak self] (index, item) in
            self!.timezoneTextField.text = item
            self!.timezoneID = self!.timezonelistdetails[index].iD
    }
        dropDown.show()
    }
    @IBAction func btnsave(_ sender: Any) {
        updateprofile()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
   //MARK: ScrollView Delegate Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = Float(scrollView.frame.size.height)
        let scrollContentSizeHeight = Float(scrollView.contentSize.height)
        let scrollOffset = Float(scrollView.contentOffset.y)
        
        if scrollOffset + scrollViewHeight == scrollContentSizeHeight {
            //    floationgrobotButton.isEnabled = true
        }
    }

    //MARK:Webservice call
    func gettimezonelist()
    {
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModeltimezonelistDetails?.gettimezonelist(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        timezonelistdetails = viewModeltimezonelistDetails!.timezonelist
                        print(timezonelistdetails)
                        for i in 0..<timezonelistdetails.count
                        {
                            arraytimezones.append(timezonelistdetails[i].name!)
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
    
  func updateprofile()
  {
    
    var parameters = [String:Any]()
  
        parameters = [
            "ClientID" : clientid!,
            "CustID" : "1",
            "PhoneNo" : phoneNumbertextfield.text!,
            "Department" :departmentTextfield.text!,
            "Designation" : designationTextField.text!,
            "CompanyName" : companynameTextField.text!,
            "CompanyCountry" : "",
            "State" : "",
            "Industry" : industryTextField.text!,
            "TimezoneID" : timezoneID!

        ]
    
    print(parameters)
    let headers = [
        "AppName":"IntelgicApp",
        "Token":token!as! String,
    ]
    Alamofire.request("http://3.7.99.38:5001/api/Customer/ProfileUpdate?", method:.post, parameters: parameters,encoding: JSONEncoding.default,headers: headers) .responseJSON { (response) in
           print(response)
        // Create the alert controller
            let alertController = UIAlertController(title: "", message: "Profile Updated", preferredStyle: .alert)

            // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            let VC = CompanyProfileVC(nibName: "CompanyProfileVC", bundle: nil)
            self.navigationController?.pushViewController(VC, animated: true)
            }
        
            // Add the actions
            alertController.addAction(okAction)
          

            // Present the controller
            self.present(alertController, animated: true, completion: nil)
       }
  }
    
 
    }


