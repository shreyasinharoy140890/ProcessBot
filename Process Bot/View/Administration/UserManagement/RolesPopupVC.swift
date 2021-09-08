//
//  RolesPopupVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 07/09/21.
//

import UIKit

class RolesPopupVC: UIViewController,AlertDisplayer {
    let productCellId = "RolesTableViewCell"
    @IBOutlet weak var rolesTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    var viewModelroleslistDetails:UserManagementViewModelProtocol?
    var rolelistdetails = [RoleListModel]()
    var arrayfirstnamelist = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.bounds.size = CGSize(width: 300, height: 250)
        // Register cell
//        rolesTableView.register(UINib.init(nibName: productCellId, bundle: nil), forCellReuseIdentifier: productCellId)
//        rolesTableView.rowHeight = UITableView.automaticDimension
//        rolesTableView.separatorColor = UIColor.clear
        self.viewModelroleslistDetails = UserManagementViewModel()
        viewModelroleslistDetails?.manager = RequestManager()
        getrolelist()
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
