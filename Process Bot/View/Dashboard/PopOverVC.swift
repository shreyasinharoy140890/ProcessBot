//
//  PopOverViewController.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 12/08/21.
//

import UIKit

class PopOverVC: UIViewController,AlertDisplayer{
  
    let productCellId = "departmentTableViewCell"
    @IBOutlet weak var departmentTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    var logoImages: [UIImage] = [UIImage(named: "human_resource_icon")!, UIImage(named: "account_icon")!,UIImage(named: "client_demo_icon")!,UIImage(named: "admin_icon")!,UIImage(named: "crm_icon")!]
    var viewModelDirectoryDetails:DirectoryDetailsViewModelProtocol?
    var robotdetails:RobotViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModelDirectoryDetails = DirectoryDetailsViewModel()
        self.robotdetails = RobotViewModel()
        viewModelDirectoryDetails?.manager = RequestManager()
        // Do any additional setup after loading the view.
        contentView.bounds.size = CGSize(width: 300, height: 250)
        // Register cell
        departmentTableView.register(UINib.init(nibName: productCellId, bundle: nil), forCellReuseIdentifier: productCellId)
        departmentTableView.rowHeight = UITableView.automaticDimension
        departmentTableView.separatorColor = UIColor.clear
      //  departmentTableView.reloadData()
        callGetAllDepartmentDetails()
    }
    
    //MARK:- Button Actions (Shreya - 12.08.1990)
    @IBAction func btndismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

 //MARK:- tableview datasource and delegate (Shreya - 12.08.2021)
    
    extension PopOverVC: UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModelDirectoryDetails?.departmentarray.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as! departmentTableViewCell
            cell.selectionStyle = .none
            print(viewModelDirectoryDetails?.departmentarray)
            cell.departmentLabel.text = viewModelDirectoryDetails?.departmentarray[indexPath.row].directoryName ?? ""
            return cell
        }
  
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            print(viewModelDirectoryDetails?.departmentarray[indexPath.row].directoryID!)
            let directoryid =   UserDefaults.standard.set(viewModelDirectoryDetails?.departmentarray[indexPath.row].directoryID!, forKey: "SELECTEDDIRECTORYID")
         
            dismiss(animated: true, completion: nil)
        }
   
    }

// MARK:- Api Call (Shreya - 13.08.21)

extension PopOverVC {
    func callGetAllDepartmentDetails(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelDirectoryDetails?.getDirectoryList( directoryId:"0", completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    
                    self.departmentTableView.reloadData()
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
