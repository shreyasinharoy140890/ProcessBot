    //
    //  RobotDetailsVC.swift
    //  Process Bot
    //
    //  Created by DIPIKA GHOSH on 26/07/21.
    //

    import UIKit

    class RobotDetailsVC: UIViewController,AlertDisplayer {
        
        @IBOutlet weak var btnMenu: UIButton!
        @IBOutlet weak var viewRobotDetails: UIView!
        @IBOutlet weak var viewHeader: UIView!
        @IBOutlet weak var tableRobotDetails: UITableView!
        @IBOutlet weak var imgRobot: UIImageView!
        @IBOutlet weak var lblRobotName: UILabel!
        
        
        var arrayDetails = [["Event ID","678FGBRGB-787bhfbgvh"],["Host name","678FGBRGB"],["User Name","Worker2"],["Robot Name","Stock-Journal"],["Event Execution time","2hr,2min,10secs"],["Status","Completed"],["Version","Completed"],["created On","Completed"],["Robot Type","Attended"]]
        var robotimg:String?
        var robotname:String?
        var dictRobotDetails:PublishedRobotModel?
        var dictRobotDetailsInAction:InActionModel?
        var dictRobotLogHistory:logHistoryModel?
        var viewModelRobotDetails:RobotDetailsViewModelProtocol?
        var srtWorkerType:String?
        var triggerid:String?
        var dictLogHistory:robitDetailsModel?


        override func viewDidLoad() {
            super.viewDidLoad()
            SidePanelViewController.default.delegate = self
            tableRobotDetails.delegate = self
            tableRobotDetails.dataSource = self
            tableRobotDetails.register(RobotDetailsTableViewCell.self)
            viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
            tableRobotDetails.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 3.0, opacity: 0.6)
            if robotimg != "" {
                imgRobot.downloaded(from: robotimg ?? "")
                //= UIImage(named: robotimg ?? "")
            }else {
                imgRobot.image = UIImage(named: "robot_circle_icon")
            }
            lblRobotName.text = robotname ?? ""
            self.viewModelRobotDetails = RobotDetailsViewModel ()
            viewModelRobotDetails?.manager = RequestManager()
            if let triggerd = triggerid  {
                callGetInAction(triggeredid: triggerd)
            }else {
                callGetInAction2()
            }
            
          //  tableRobotDetails.reloadData()
            
           

            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
    //        if srtWorkerType == digitalWorkerType.PublishRobot.rawValue {
    //        tableRobotDetails.reloadData()
    //        }else if (srtWorkerType == digitalWorkerType.Inaction.rawValue){
    //            tableRobotDetails.reloadData()
    //        }
        }

        @IBAction func btnMenu(_ sender: UIButton) {
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
    extension RobotDetailsVC : UITableViewDataSource,UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayDetails.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: RobotDetailsTableViewCell.self), for: indexPath) as! RobotDetailsTableViewCell
            
            cell.lblPostName.text = arrayDetails[indexPath.row][0]
            cell.cellSetup(index: indexPath.row, workerType: srtWorkerType ?? "")
            cell.dictPublishDetails = dictRobotDetails
            cell.dictInActionDetails = dictRobotDetailsInAction
            if srtWorkerType == digitalWorkerType.LogHistory.rawValue {
                cell.dictLogHistory = dictLogHistory
                if (indexPath.row == 0 ){
                    cell.lblPostDetails.text = dictLogHistory?.publishedScriptID
                }else if (indexPath.row == 1){
                    cell.lblPostDetails.text = dictLogHistory?.machineName
                }
            }

            cell.selectionStyle = .none
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }
        
      
        
        
    }

    extension RobotDetailsVC:SidePanelDelegate {
       func didDisplayMenu(status: Bool) {
            if status == false {
                btnMenu.isSelected = false
            }
        }
        
    }

    extension RobotDetailsVC {
        func callGetInAction(triggeredid:String){
            DispatchQueue.main.async {
                showActivityIndicator(viewController: self)
            }
            viewModelRobotDetails?.callLogHistoryRobotDetails(triggeredId:triggeredid ,completion: { result in
                switch result {
                case .success(let result):
                    if let success = result as? Bool , success == true {
                        self.srtWorkerType = digitalWorkerType.Scheduled.rawValue
                        self.dictLogHistory = self.viewModelRobotDetails?.arrayLogHistory[0]
                        print(self.dictLogHistory as Any)
                        let delay = 15
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                        hideActivityIndicator(viewController: self)
                       
                        self.tableRobotDetails.reloadData()
                        }
                       // self.callGetInAction2()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        hideActivityIndicator(viewController: self)
                        self.showAlertWith(message: error.localizedDescription)
                    }
                    
                }
            })
        }
        func callGetInAction2(){
            DispatchQueue.main.async {
                showActivityIndicator(viewController: self)
            }
            viewModelRobotDetails?.callInAction(completion: { result in
                switch result {
                case .success(let result):
                    if let success = result as? Bool , success == true {
                       // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                       DispatchQueue.main.async {
                        hideActivityIndicator(viewController: self)
                        
                        self.tableRobotDetails.reloadData()
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
