//
//  LicenceInfo.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 15/09/21.
//

import UIKit
import Alamofire

class LicenceInfo: UIViewController,AlertDisplayer {
   
    @IBOutlet weak var tbllicensedetails: UITableView!
    var viewModellicencelistDetails:CompanyProfileViewModelProtocol?
    var licencelistdetails = [LicenceListModel]()
    var arrayDetails = ["Activation Date","Expiry Date","Status","Key Type","Validity","Additional Host No.","Host No.","Additional Robot No.","Robot No.","Additional User No.","User No."]
   
    var token  = UserDefaults.standard.value(forKey: "TOKEN")
    var clientid = UserDefaults.standard.value(forKey: "CLIENTID")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbllicensedetails.register(CompanyProfileTableViewCell.self)
        tbllicensedetails.reloadData()
        self.viewModellicencelistDetails = CompanyProfileViewModel()
        viewModellicencelistDetails?.manager = RequestManager()
       // calllicenceinfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        tbllicensedetails.register(CompanyProfileTableViewCell.self)
        tbllicensedetails.reloadData()
        self.viewModellicencelistDetails = CompanyProfileViewModel()
        viewModellicencelistDetails?.manager = RequestManager()
        calllicenceinfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //getLicenceInfo()
        calllicenceinfo()
        tbllicensedetails.register(CompanyProfileTableViewCell.self)
        tbllicensedetails.reloadData()
    }
//MARK: - Webservice call
   
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
                    
                    self.tbllicensedetails.reloadData()
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
 

extension LicenceInfo : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: CompanyProfileTableViewCell.self), for: indexPath) as! CompanyProfileTableViewCell
        
        cell.lblPostName.text = arrayDetails[indexPath.row]
        for i in 0..<licencelistdetails.count
        {
            showActivityIndicator(viewController: self)
            if (indexPath.row == 0)
            {
                cell.lblPostDetails.text = licencelistdetails[i].activationDate
            }
            
            if (indexPath.row == 1)
            {
                cell.lblPostDetails.text = licencelistdetails[i].nextRenewDate
            }
            if (indexPath.row == 2)
            {
                var isCurrent:Bool?
                isCurrent = licencelistdetails[i].isCurrent
                let boolAsString = String(isCurrent!)
                cell.lblPostDetails.text = boolAsString
            }
            if (indexPath.row == 3)
            {
                cell.lblPostDetails.text = licencelistdetails[i].KeyType
            }
            if (indexPath.row == 4)
            {
                let validity : Int = licencelistdetails[i].validity!
                let validityString = String(validity)
               cell.lblPostDetails.text = validityString
            }
            if (indexPath.row == 5)
            {
                let additionalhostno : Int = licencelistdetails[i].additionalHostNo!
                let additionalhostnoString = String(additionalhostno)
               cell.lblPostDetails.text = additionalhostnoString
            }
            if (indexPath.row == 6)
            {
                let hostno:Int = licencelistdetails[i].hostNo!
                let hostnoString = String(hostno)
                cell.lblPostDetails.text = hostnoString

            }
            if (indexPath.row == 7)
            {
                let additionalrobotno:Int = licencelistdetails[i].additionalRobotNo!
                let additionalrobotnoString = String(additionalrobotno)
                cell.lblPostDetails.text = additionalrobotnoString
            }
            if (indexPath.row == 8)
            {
                let robotno:Int = licencelistdetails[i].robotNo!
                let additionalrobotnoString = String(robotno)
                cell.lblPostDetails.text = additionalrobotnoString

            }
            if (indexPath.row == 9)
            {
                let additionaluserno:Int = licencelistdetails[i].additionalUserNo!
                let additionalusernoString = String(additionaluserno)
                cell.lblPostDetails.text = additionalusernoString
            }
            if (indexPath.row == 10)
            {
                let userno:Int = licencelistdetails[i].userNo!
                let usernoString = String(userno)
                cell.lblPostDetails.text = usernoString
            }
            
            
            
            hideActivityIndicator(viewController: self)
        }
        
      
        print(cell.lblPostDetails.text!)
      
        cell.cellSetup(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
