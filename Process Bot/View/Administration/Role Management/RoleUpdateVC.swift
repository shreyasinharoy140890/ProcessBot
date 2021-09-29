//
//  RoleUpdateVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 28/09/21.
//

import UIKit

class RoleUpdateVC: UIViewController,AlertDisplayer, SidePanelDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var textfieldrolename: UITextField!
    @IBOutlet weak var textfieldroledescription: UITextField!
    @IBOutlet weak var viewroleList: UIView!
    @IBOutlet weak var tablerolelist: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    
    var viewModelpermissionlistDetails:PermissionViewModelProtocol?
    var permissionlistdetails = [PermissionListModel]()
    var componentcodeString:String?
    var componentIDString:Int?
    var componentNameString:String?
    var componentdescription:String?
    var isedit:Bool?
    var isView:Bool?
    var isDelete:Bool?
    var isAdd:Bool?
    var componentcode:String?
    var arraycomponentName = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.viewModelpermissionlistDetails = PermissionViewModel()
        viewModelpermissionlistDetails?.manager = RequestManager()
        getpermissionlist()
        textfieldrolename.text = componentNameString
        textfieldroledescription.text = componentdescription
        tablerolelist.delegate = self
        tablerolelist.dataSource = self
        tablerolelist.register(RoleUpdateTableViewCell.self)
        SidePanelViewController.default.delegate = self
        scrollView.delegate = self
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    func setupUI (){
    
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewMain.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewroleList.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
        textfieldrolename.layer.borderWidth = 2
        textfieldrolename.layer.borderColor = UIColor.lightGray.cgColor
        textfieldrolename.layer.cornerRadius = 8
        textfieldrolename.isUserInteractionEnabled = false
      
        
        textfieldroledescription.layer.borderWidth = 2
        textfieldroledescription.layer.borderColor = UIColor.lightGray.cgColor
        textfieldroledescription.layer.cornerRadius = 8
        textfieldroledescription.isUserInteractionEnabled = false
       
        
        buttonSave.layer.cornerRadius = 8
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
    

  //MARK: Webservice Call
    func getpermissionlist()
    {
       
       DispatchQueue.main.async {
           //   showActivityIndicator(viewController: self)
       }
       viewModelpermissionlistDetails?.getPermissionList(completion: { result in
           switch result {
           case .success(let result):
               if let success = result as? Bool , success == true {
                   DispatchQueue.main.async { [self] in
                       
                    permissionlistdetails =   viewModelpermissionlistDetails!.permissionlist
                    print(permissionlistdetails)
                       for i in 0..<permissionlistdetails.count
                       {
                        arraycomponentName.append(permissionlistdetails[i].componentName!)
  
               }
                    tablerolelist.reloadData()
                    
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
       
    
    //MARK:- Button Actions
       @IBAction func btnMenuAction(_ sender: UIButton) {
           if sender.isSelected {
               SidePanelViewController.default.hide()
               sender.isSelected = false
           }
           else {
               SidePanelViewController.default.show(on: self)
               sender.isSelected = true
           }
       }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension RoleUpdateVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraycomponentName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: RoleUpdateTableViewCell.self), for: indexPath) as! RoleUpdateTableViewCell
        cell.labelroleName.text = arraycomponentName[indexPath.row]
        print(cell.labelroleName.text)
        isView = permissionlistdetails[indexPath.row].isView
        print(isView)
        if isView == true
        {
            if let image = UIImage(named: "check_tick.png") {
                cell.buttonView.setImage(image, for: .normal)
            }
        }
        else
        {
            if let image = UIImage(named: "check_untick.png") {
                cell.buttonView.setImage(image, for: .normal)
            }
        }
        isAdd = permissionlistdetails[indexPath.row].isAdd
        isedit = permissionlistdetails[indexPath.row].isEdit
        isDelete = permissionlistdetails[indexPath.row].isDelete
       
        
        
        
        cell.cellSetup(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
   
    }



