//
//  StandAloneVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 25/08/21.
//

import UIKit
import SignalRSwift
import MaterialComponents.MaterialSnackbar
class StandAloneVC: UIViewController,AlertDisplayer {
    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableStandAlone: UITableView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    var isFiltering = false
    var hub: HubProxy!
    var connection: HubConnection!
    var name: String!
    let clientId  = UserDefaults.standard.value(forKey: "CLIENTID")
    let token  = UserDefaults.standard.value(forKey: "TOKEN")
    let appName = UserDefaults.standard.value(forKey:"APPNAME")
    var viewModelstandaloneDetails:MachineHostViewModelProtocol?
    var machinehostdetails = [MachineHostModel]()
    var arraymachinename = [String]()
    var arrayusername = [String]()
    var arrayremarks = [String]()
    var arraykeys = [String]()
    var machinekey:String?
    var filtered = [MachineHostModel]()
    var searchText:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModelstandaloneDetails = MachineHostViewModel()
        viewModelstandaloneDetails?.manager = RequestManager()
        tableStandAlone.delegate = self
        tableStandAlone.dataSource = self
        tableStandAlone.register(StandAloneTableViewCell.self)
        SidePanelViewController.default.delegate = self
        setupUI()
        textFieldSearch.text = searchText
        let qs = ["AppName":appName as! String,
                  "Token": token as! String,
                  "ClientID":clientId as! String
        
        ]
        print(qs)
        
        connection = HubConnection(withUrl: "http://3.7.99.38:5001/signalr",queryString: qs)
 
        // SignalR events

        connection.started = { [unowned self] in
            print("connected")
            
        }

        connection.reconnecting = { [unowned self] in
            print("reconnecting")
        }

        connection.reconnected = { [unowned self] in
            print("reconnected")
        }

        connection.closed = { [unowned self] in
            print("closed")
        }

        connection.connectionSlow = { print("Connection slow...") }

        connection.error = { [unowned self] error in
            let anError = error as NSError
            if anError.code == NSURLErrorTimedOut {
                self.connection.start()
            }
        }

        connection.start()
        getstandalonedetails()
        textFieldSearch.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
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
    @objc func buttonViewLinkAction(sender:UIButton!) {
            print("Button tapped")
        
    UIPasteboard.general.string = machinekey
    print(UIPasteboard.general.string!)
        let message = MDCSnackbarMessage()
        message.text = UIPasteboard.general.string!
        MDCSnackbarManager.default.show(message)
        }
   
//MARK:- Webservice Calling
    
    func getstandalonedetails()
    {
        DispatchQueue.main.async {
           // showActivityIndicator(viewController: self)
        }
        viewModelstandaloneDetails?.machineHostDetails( completion: { [self] result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async {
                     hideActivityIndicator(viewController: self)
                        self.machinehostdetails = self.viewModelstandaloneDetails!.machinearray
                        print(self.machinehostdetails)
                        for i in 0..<machinehostdetails.count
                        {
                            if machinehostdetails[i].oSType == "Standalone"
                            {
                                arraymachinename.append(machinehostdetails[i].machineName!)
                                arrayusername.append(machinehostdetails[i].userName!)
                                arrayremarks.append(machinehostdetails[i].conRemarks!)
                                arraykeys.append(machinehostdetails[i].machineKey!)
                                for i in 0..<arraykeys.count
                                {
                                    machinekey = arraykeys[i]
                                }
                            }
                        }
                      
               print(arraymachinename)
               print(arrayusername)
               print(arrayremarks)
               print(arraykeys)
               tableStandAlone.reloadData()
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
//MARK: TableView datasource and delegate
extension StandAloneVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering == true ? filtered.count : arraymachinename.count
       // return arraymachinename.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: StandAloneTableViewCell.self), for: indexPath) as! StandAloneTableViewCell
        
          
        cell.lblRemarksValue.text = arrayremarks[indexPath.row]
        cell.lblMachineNameValue.text = arraymachinename[indexPath.row]
        cell.lblUserTypeValue.text = arrayusername[indexPath.row]
        cell.btnkeys.addTarget(self, action: #selector(buttonViewLinkAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension StandAloneVC:SidePanelDelegate,UITextFieldDelegate {
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    @objc func textFieldValueChange(_ txt: UITextField)  {
        searchText = textFieldSearch.text!
        
        if (searchText != ""){
            isFiltering = true

            filtered = machinehostdetails.filter {
                $0.machineName?.range(of: searchText!, options: .caseInsensitive, range: nil, locale: nil) != nil
                        }
                        print(filtered)
            
        }else {
            isFiltering = false
            filtered = machinehostdetails
        }
        self.tableStandAlone.reloadData()
    }
    
    
}



