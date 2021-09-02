//
//  ServerVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 01/09/21.
//

import UIKit
import SignalRSwift
class ServerVC: UIViewController,AlertDisplayer, SidePanelDelegate, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var tableServer: UITableView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnMenu: UIButton!
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModelstandaloneDetails = MachineHostViewModel()
        viewModelstandaloneDetails?.manager = RequestManager()
        tableServer.delegate = self
        tableServer.dataSource = self
        tableServer.register(StandAloneTableViewCell.self)
        SidePanelViewController.default.delegate = self
        setupUI()
        getserverdetails()
    }


    func setupUI (){
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewSearch.layer.cornerRadius = 8
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
    }
    
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
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
    
  //MARK:- TableView datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraymachinename.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: StandAloneTableViewCell.self), for: indexPath) as! StandAloneTableViewCell
        cell.lblRemarksValue.text = arrayremarks[indexPath.row]
        cell.lblMachineNameValue.text = arraymachinename[indexPath.row]
        cell.lblUserTypeValue.text = arrayusername[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

//MARK:- Webservice Call
    func getserverdetails()
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
                            if machinehostdetails[i].oSType == "Server"
                            {
                                arraymachinename.append(machinehostdetails[i].machineName!)
                                arrayusername.append(machinehostdetails[i].userName!)
                                arrayremarks.append(machinehostdetails[i].conRemarks!)
                                arraykeys.append(machinehostdetails[i].machineKey!)
                            }
                        }
                      
               print(arraymachinename)
               print(arrayusername)
               print(arrayremarks)
               print(arraykeys)
               tableServer.reloadData()
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

    
    

