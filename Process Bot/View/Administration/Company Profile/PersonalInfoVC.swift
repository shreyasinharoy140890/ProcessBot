//
//  PersonalInfoVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 15/09/21.
//

import UIKit
import TimeZonePicker
import DropDown

class PersonalInfoVC: UIViewController,AlertDisplayer {
    @IBOutlet weak var buttonupdate: UIButton!
    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var tblpersonaldetails: UITableView!
    var imageView:UIImage?
    var arraydetails = [String]()
    var arraytimezones = [String]()
    var emailString:String?
    var number:String?
    var department:String?
    var designation:String?
    var companyname:String?
    var industry:String?
    var timezone:String?
    var timezoneid:String?
    var viewModelprofilelistDetails:CompanyProfileViewModelProtocol?
    var profilelistdetails = [ProfileListModel]()
    var arrayDetails = ["Email","Phone Number","Department","Designation","Company Name","Industry","Time Zone"]
    let dropDown = DropDown()
    var viewModeltimezonelistDetails:CompanyProfileViewModel?
    var timezonelistdetails = [TimeZoneModel]()
    var token  = UserDefaults.standard.value(forKey: "TOKEN")
    var clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    var licencelistdetails = [LicenceListModel]()
    var viewModellicencelistDetails:CompanyProfileViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tblpersonaldetails.register(CompanyProfileTableViewCell.self)
        tblpersonaldetails.reloadData()
        self.viewModelprofilelistDetails = CompanyProfileViewModel()
        viewModelprofilelistDetails?.manager = RequestManager()
        self.viewModeltimezonelistDetails = CompanyProfileViewModel()
        viewModeltimezonelistDetails?.manager = RequestManager()
        self.viewModellicencelistDetails = CompanyProfileViewModel()
        viewModellicencelistDetails?.manager = RequestManager()
        calllicenceinfo()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        tblpersonaldetails.register(CompanyProfileTableViewCell.self)
        tblpersonaldetails.reloadData()
        self.viewModelprofilelistDetails = CompanyProfileViewModel()
        viewModelprofilelistDetails?.manager = RequestManager()
        self.viewModeltimezonelistDetails = CompanyProfileViewModel()
        viewModeltimezonelistDetails?.manager = RequestManager()
       // callProfileDetails()
        gettimezonelist()
        for i in 0..<profilelistdetails.count
        {
            labelname.text = profilelistdetails[i].custFullName
        }
        imageView = UIImage(named: "down-arrow")!
      
       
    }
 
    override func viewDidAppear(_ animated: Bool) {
        tblpersonaldetails.register(CompanyProfileTableViewCell.self)
        tblpersonaldetails.reloadData()
      //  callProfileDetails()
        gettimezonelist()
        for i in 0..<profilelistdetails.count
        {
            labelname.text = profilelistdetails[i].custFullName
        }
        imageView = UIImage(named: "down-arrow")!
       
    }
 
 //MARK:- Button Actions
    
    @IBAction func buttonUpdate(_ sender: Any) {
        let VC = UpdateProfileVC(nibName: "UpdateProfileVC", bundle: nil)
        VC.email = emailString
        VC.phone = number
        VC.department = department
        VC.designation = designation
        VC.companyname = companyname
        VC.industry = industry
        VC.timeZone = timezone
        self.navigationController?.pushViewController(VC, animated: true)
        
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
                emailString = profilelistdetails[i].workEmail
            }
            
            if (indexPath.row == 1)
            {
                cell.lblPostDetails.text = profilelistdetails[i].phoneNo
            number = profilelistdetails[i].phoneNo
            }
            if (indexPath.row == 2)
            {
                cell.lblPostDetails.text = profilelistdetails[i].department
                department = profilelistdetails[i].department
            }
            if (indexPath.row == 3)
            {
                cell.lblPostDetails.text = profilelistdetails[i].designation
                designation = profilelistdetails[i].designation
            }
            if (indexPath.row == 4)
            {
                cell.lblPostDetails.text = profilelistdetails[i].companyName
                companyname = profilelistdetails[i].companyName
            }
            if (indexPath.row == 5)
            {
                cell.lblPostDetails.text = profilelistdetails[i].industry
                industry = profilelistdetails[i].industry
            }
            if (indexPath.row == 6)
            {
//                let currentTimeZone = TimeZone.current
//                cell.lblPostDetails.text =  currentTimeZone.identifier + " " + currentTimeZone.abbreviation()!
//                timezone =  cell.lblPostDetails.text
                print(timezone)
                cell.lblPostDetails.text = timezone
              
              
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
                        for i in 0..<profilelistdetails.count
                        {
                            print(profilelistdetails[i].custID!)
                          
                            timezoneid = profilelistdetails[i].timeZoneID!
                        }
                       
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

    func gettimezonelist()
    {
    callProfileDetails()
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
                        self.tblpersonaldetails.reloadData()
                        for i in 0..<timezonelistdetails.count
                        {
                            arraytimezones.append(timezonelistdetails[i].name!)
                            if timezonelistdetails[i].iD! == timezoneid
                            {
                               timezone = timezonelistdetails[i].name!
                            }
                        }
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

    func calllicenceinfo()
    {
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModellicencelistDetails?.getlicencedetails(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        licencelistdetails = viewModellicencelistDetails!.licencelist
                        print(licencelistdetails)
                        for i in 0..<licencelistdetails.count
                        {
                            UserDefaults.standard.set(self.licencelistdetails[i].custID!, forKey: "CUSTOMERID")
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


}
