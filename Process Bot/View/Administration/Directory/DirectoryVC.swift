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
    var searchText:String?
    var filtered = [DirectoryModel]()
    var isFiltering = false
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tabledirectorylist.performBatchUpdates(nil)
            
        }
    }
}
