//
//  DirectoryVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 26/10/21.
//

import UIKit

class DirectoryVC: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tabledirectorylist: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    var viewModeldirectorylistDetails:DirectoryViewModelProtocol?
    var directorylistdetails = [DirectoryModel]()
    var arraydirectorynamelist = [String]()
    var arraydirectorydescriptionlist = [String]()
    var arraydatelist = [String]()
    var searchText:String?
    var filtered = [DirectoryModel]()
    var isFiltering = false
    var date:String?
    var time:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.viewModeldirectorylistDetails = DirectoryViewModel()
        viewModeldirectorylistDetails?.manager = RequestManager()
        tabledirectorylist.delegate = self
        tabledirectorylist.dataSource = self
        tabledirectorylist.register(DirectoryTableViewCell.self)
        SidePanelViewController.default.delegate = self
        textFieldSearch.delegate = self
        textFieldSearch.text = searchText
        textFieldSearch.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        getdirectorylist()
    }
    override func viewWillAppear(_ animated: Bool) {
      
    }
    override func viewDidAppear(_ animated: Bool) {
      
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
            
            filtered = directorylistdetails.filter {
                $0.ownerID?.range(of: searchText!, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            print(filtered)
            
        }else {
            isFiltering = false
            filtered = directorylistdetails
        }
        self.tabledirectorylist.reloadData()
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
    @IBAction func buttonTap(sender: UIButton) {
        let VC = AddDirectoryVC(nibName: "AddDirectoryVC", bundle: nil)
        
        VC.modalPresentationStyle = .automatic
        VC.preferredContentSize = CGSize(width: 300, height: 200)
        self.navigationController?.present(VC, animated: true, completion: nil)
        
    }
}
extension DirectoryVC:SidePanelDelegate,AlertDisplayer {
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    //MARK:- Webservice Call
    
    func getdirectorylist()
    {
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModeldirectorylistDetails?.getDirectoryList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        directorylistdetails =   viewModeldirectorylistDetails!.directorylist
                        print(directorylistdetails)
                        for i in 0..<directorylistdetails.count
                        {
                        arraydirectorynamelist.append(directorylistdetails[i].directoryName!)
                        arraydirectorydescriptionlist.append(directorylistdetails[i].description!)
                        arraydatelist.append(directorylistdetails[i].createDate!)
                        tabledirectorylist.reloadData()
                      
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

extension DirectoryVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraydirectorynamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: DirectoryTableViewCell.self), for: indexPath) as! DirectoryTableViewCell
        cell.labeldirectoryname.text = arraydirectorynamelist[indexPath.row]
        cell.labeldescription.text = arraydirectorydescriptionlist[indexPath.row]
        date = arraydatelist[indexPath.row]
        time = arraydatelist[indexPath.row]
        print(date!.stringBefore("T"))
        print(time!.stringAfter("T"))
        let datestring = date!.stringBefore("T")
        let timestring = time!.stringAfter("T")
        cell.labeldate.text = datestring
        cell.labeltime.text = timestring
        cell.buttonedit.addTarget(self, action: #selector(navigatetonext(_:)), for: .touchUpInside)
        cell.buttonedit.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tabledirectorylist.performBatchUpdates(nil)
            print(self.directorylistdetails[indexPath.row].directoryID!)
            UserDefaults.standard.set(self.directorylistdetails[indexPath.row].directoryID!, forKey: "DIRECTORY_ID")
            
        }
    }
    @objc func navigatetonext(_ sender:UIButton)
    {
        let cell = tabledirectorylist.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? DirectoryTableViewCell
        if (sender.isSelected){
            let VC = UpdateDirectoryVC(nibName: "UpdateDirectoryVC", bundle: nil)
            
            VC.modalPresentationStyle = .automatic
            VC.preferredContentSize = CGSize(width: 300, height: 200)
            VC.directoryname = arraydirectorynamelist[sender.tag]
            VC.directorydescription = arraydirectorydescriptionlist[sender.tag]
            self.navigationController?.present(VC, animated: true, completion: nil)
           
        }else {
           
            sender.isSelected = true
        
        }
     
    }
}
