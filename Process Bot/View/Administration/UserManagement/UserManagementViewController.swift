//
//  UserManagementViewController.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 06/09/21.
//

import UIKit

class UserManagementViewController: UIViewController{
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableusers: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    
    var viewModeluserlistDetails:UserManagementViewModelProtocol?
    var userlistdetails = [UserListModel]()
    var arrayfirstnamelist = [String]()
    var arrayemaillist = [String]()
    var arraytimelist = [String]()
    var arraydatelist = [String]()
    var date:String?
    var time:String?
    var filtered = [UserListModel]()
    var searchText:String?
    var isFiltering = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableusers.delegate = self
        tableusers.dataSource = self
        tableusers.register(UserManagementTableViewCell.self)
        SidePanelViewController.default.delegate = self
        setupUI()
        self.viewModeluserlistDetails = UserManagementViewModel()
        viewModeluserlistDetails?.manager = RequestManager()
        callGetuserlistDetails()
        textFieldSearch.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        textFieldSearch.text = searchText
    }


    func setupUI (){
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewSearch.layer.cornerRadius = 8
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
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
extension UserManagementViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayfirstnamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: UserManagementTableViewCell.self), for: indexPath) as! UserManagementTableViewCell
        cell.labelusername.text = arrayfirstnamelist[indexPath.row]
        cell.labeluseremail.text = arrayemaillist[indexPath.row]
        cell.labelfullname.text = arrayfirstnamelist[indexPath.row]
        date = arraydatelist[indexPath.row]
        print(date!.stringBefore("T"))
        let datestring = date!.stringBefore("T")
        cell.labeldate.text = datestring
        time = userlistdetails[indexPath.row].lastSuccessfulLogin
        let timestring = time!.stringAfter("T")
        cell.labeltime.text = timestring
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       UIView.animate(withDuration: 0.3) {
           self.tableusers.performBatchUpdates(nil)
       
}
    }
}
extension UserManagementViewController:SidePanelDelegate {
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    @objc func textFieldValueChange(_ txt: UITextField)  {
        searchText = textFieldSearch.text!
        
        if (searchText != ""){
            isFiltering = true

            filtered = userlistdetails.filter {
                $0.fullName?.range(of: searchText!, options: .caseInsensitive, range: nil, locale: nil) != nil
                        }
                        print(filtered)
            
        }else {
            isFiltering = false
            filtered = userlistdetails
        }
        self.tableusers.reloadData()
    }
    
}
extension UserManagementViewController:AlertDisplayer
{
//MARK:- Webservice Call
    func callGetuserlistDetails(){
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModeluserlistDetails?.getUsersList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        userlistdetails = viewModeluserlistDetails!.usersdetails
                        print(userlistdetails)
                        for i in 0..<userlistdetails.count
                        {
                            print(userlistdetails[i].username!)
                            arrayfirstnamelist.append(userlistdetails[i].fullName!)
                            arrayemaillist.append(userlistdetails[i].email!)
                            arraydatelist.append(userlistdetails[i].createDate!)
                            
                            arraytimelist.append(userlistdetails[i].lastSuccessfulLogin!)
                            time = userlistdetails[i].lastSuccessfulLogin!
                        }
                        self.tableusers.reloadData()
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
extension String {
    func stringBefore(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(prefix(upTo: index))
        } else {
            return ""
        }
    }
    
    func stringAfter(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(suffix(from: index).dropFirst())
        } else {
            return ""
        }
    }
}
