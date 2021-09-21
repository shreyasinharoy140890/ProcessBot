//
//  PersonalInfoVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 15/09/21.
//

import UIKit
import TimeZonePicker

class PersonalInfoVC: UIViewController,AlertDisplayer, TimeZonePickerDelegate {
    @IBOutlet weak var buttonupdate: UIButton!
    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var tblpersonaldetails: UITableView!
    var imageView:UIImage?
    var arraydetails = [String]()
    var emailString:String?
    var number:String?
    var department:String?
    var designation:String?
    var companyname:String?
    var industry:String?
    var timezone:String?
    var viewModelprofilelistDetails:CompanyProfileViewModelProtocol?
    var profilelistdetails = [ProfileListModel]()
    var arrayDetails = ["Email","Phone Number","Department","Designation","Company Name","Industry","Time Zone"]
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tblpersonaldetails.register(CompanyProfileTableViewCell.self)
        tblpersonaldetails.reloadData()
        self.viewModelprofilelistDetails = CompanyProfileViewModel()
        viewModelprofilelistDetails?.manager = RequestManager()
      //  callProfileDetails()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        tblpersonaldetails.register(CompanyProfileTableViewCell.self)
        tblpersonaldetails.reloadData()
        self.viewModelprofilelistDetails = CompanyProfileViewModel()
        viewModelprofilelistDetails?.manager = RequestManager()
        callProfileDetails()
        for i in 0..<profilelistdetails.count
        {
            labelname.text = profilelistdetails[i].custFullName
        }
        imageView = UIImage(named: "down-arrow")!
    }
 
    override func viewDidAppear(_ animated: Bool) {
        tblpersonaldetails.register(CompanyProfileTableViewCell.self)
        tblpersonaldetails.reloadData()
        callProfileDetails()
        for i in 0..<profilelistdetails.count
        {
            labelname.text = profilelistdetails[i].custFullName
        }
        imageView = UIImage(named: "down-arrow")!
    }
   
   
}
extension PersonalInfoVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: CompanyProfileTableViewCell.self), for: indexPath) as! CompanyProfileTableViewCell
        
        cell.lblPostName.text = arrayDetails[indexPath.row]
        for i in 0..<profilelistdetails.count
        {
            showActivityIndicator(viewController: self)
            if (indexPath.row == 0)
            {
                cell.lblPostDetails.text = profilelistdetails[i].workEmail
            }
            
            if (indexPath.row == 1)
            {
                cell.lblPostDetails.text = profilelistdetails[i].phoneNo
            }
            if (indexPath.row == 2)
            {
                cell.lblPostDetails.text = profilelistdetails[i].department
            }
            if (indexPath.row == 3)
            {
                cell.lblPostDetails.text = profilelistdetails[i].designation
            }
            if (indexPath.row == 4)
            {
                cell.lblPostDetails.text = profilelistdetails[i].companyName
            }
            if (indexPath.row == 5)
            {
                cell.lblPostDetails.text = profilelistdetails[i].industry
            }
            if (indexPath.row == 6)
            {
                cell.lblPostDetails.text = profilelistdetails[i].timeZoneID
                let button = UIButton()
                button.frame = CGRect(x: self.view.frame.size.width - 80, y: 20, width: 20, height: 20)
               
              
                button.setImage( imageView!, for: .normal)
                button.addTarget(self, action: #selector(openpicker), for: .touchUpInside)
                cell.addSubview(button)
                
            }
            hideActivityIndicator(viewController: self)
        }
        
      
    
        cell.cellSetup(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
  //MARK: Webservice Call
    func callProfileDetails(){
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModelprofilelistDetails?.getProfileList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        profilelistdetails = viewModelprofilelistDetails!.profilelist
                        print(profilelistdetails)
                        self.tblpersonaldetails.reloadData()
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
    
    @objc func openpicker()
  {
    let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
    present(timeZonePicker, animated: true, completion: nil)
}
  
 func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
        print(timeZone.identifier)
      //  timeZoneName.text = timeZone.identifier
       // timeZoneOffset.text = timeZone.abbreviation()
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
  
}
    

