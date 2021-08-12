//
//  PopOverViewController.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 12/08/21.
//

import UIKit

class PopOverVC: UIViewController {
  
    let productCellId = "departmentTableViewCell"
    @IBOutlet weak var departmentTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    
    var departmentarray:NSArray = ["Human Resource","Account & Finance","Client Demo","Admin","CRM"]
    var logoImages: [UIImage] = [UIImage(named: "human_resource_icon")!, UIImage(named: "account_icon")!,UIImage(named: "client_demo_icon")!,UIImage(named: "admin_icon")!,UIImage(named: "crm_icon")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contentView.bounds.size = CGSize(width: 300, height: 250)
        // Register cell
        departmentTableView.register(UINib.init(nibName: productCellId, bundle: nil), forCellReuseIdentifier: productCellId)
        departmentTableView.rowHeight = UITableView.automaticDimension
        departmentTableView.separatorColor = UIColor.clear
        departmentTableView.reloadData()
    }
    
    //MARK:- Button Actions (Shreya - 12.08.1990)
    @IBAction func btndismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

 //MARK:- tableview datasource and delegate (Shreya - 12.08.1990)
    
    extension PopOverVC: UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return departmentarray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as! departmentTableViewCell
            cell.selectionStyle = .none
            cell.departmentLabel.text = departmentarray[indexPath.row] as! String
            cell.departmentImageView.image = logoImages[indexPath.row]
          //  cell.lbDesc.text = product.desc!
            return cell
        }
        
        
    }

