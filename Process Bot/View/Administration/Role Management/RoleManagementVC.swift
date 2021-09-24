
import UIKit

class RoleManagementVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tablerolelist: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    var viewModelroleslistDetails:UserManagementViewModelProtocol?
    var rolelistdetails = [RoleListModel]()
    var arrayrolenamelist = [String]()
    var arrayroledescriptionlist = [String]()
    var arrayusernamelist = [String]()
    var usercountlist = [Int]()
    var datelist = [String]()
    var timelist = [String]()
    var rolename:String?
    var roledescription:String?
    var usercount:String?
    var date:String?
    var searchText:String?
    var filtered = [RoleListModel]()
    var isFiltering = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.viewModelroleslistDetails = UserManagementViewModel()
        viewModelroleslistDetails?.manager = RequestManager()
        getrolelist()
        tablerolelist.delegate = self
        tablerolelist.dataSource = self
        tablerolelist.register(RoleManagementTableViewCell.self)
        SidePanelViewController.default.delegate = self
        textFieldSearch.delegate = self
        textFieldSearch.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        textFieldSearch.text = searchText
    }
    
    func setupUI (){
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewSearch.layer.cornerRadius = 8
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
    }
    @objc func textFieldValueChange(_ txt: UITextField)  {
        searchText = textFieldSearch.text!
        
        if (searchText != ""){
            isFiltering = true

            filtered = rolelistdetails.filter {
                $0.createdBy?.range(of: searchText!, options: .caseInsensitive, range: nil, locale: nil) != nil
                        }
                        print(filtered)
            
        }else {
            isFiltering = false
            filtered = rolelistdetails
        }
        self.tablerolelist.reloadData()
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
extension RoleManagementVC:SidePanelDelegate,AlertDisplayer {
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
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
                                if let createdby = rolelistdetails[i].createdBy {
                                    print("No")
                                    arrayusernamelist.append(rolelistdetails[i].createdBy!)
                                } else {
                                   print("Yes")
                                    arrayusernamelist.append("None")
                                }
                                
                                
                                arrayrolenamelist.append(rolelistdetails[i].roleName!)
                                arrayroledescriptionlist.append(rolelistdetails[i].roleDescription!)
                                usercountlist.append(rolelistdetails[i].userCount!)
                                datelist.append(rolelistdetails[i].createDate!)
                               
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
}
extension RoleManagementVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayrolenamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: RoleManagementTableViewCell.self), for: indexPath) as! RoleManagementTableViewCell
        cell.labelusername.text = arrayusernamelist[indexPath.row]
        cell.labelrolename.text = arrayrolenamelist[indexPath.row]
        cell.labelroledescription.text = arrayroledescriptionlist[indexPath.row]
        cell.labelusercount.text = String(usercountlist[indexPath.row])
        date = datelist[indexPath.row]
        print(date!.stringBefore("T"))
        let datestring = date!.stringBefore("T")
        cell.labeldate.text = datestring
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
          self.tablerolelist.performBatchUpdates(nil)
       
}
    }

}
