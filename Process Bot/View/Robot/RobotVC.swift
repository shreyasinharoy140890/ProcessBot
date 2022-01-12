//
//  RobotVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 26/07/21.
//

import UIKit

class RobotVC: UIViewController,AlertDisplayer {
    
    @IBOutlet weak var viewScheduled: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tableRobot: UITableView!
    
    @IBOutlet weak var viewSearchLogHistory: UIView!
    @IBOutlet weak var viewInAction: UIView!
    @IBOutlet weak var viewToggle: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewPublish: UIView!
    @IBOutlet weak var heightConstantVwSearchLog: NSLayoutConstraint!
    
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var buttonLogHistory: UIButton!
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var textSearch: UITextField!
    
    
    var searchItem = ""
    var setIndex = Set<Int>()
    var getRobotWorkType:String = ""
    var arrayimg = [["user_pic1","David Thomas"],["user_pic2","William corry"],["user_pic3","Jhon deo"],["user_pic4","Bill gates"],["user_pic5","Nick Maybury"],["user_pic6","Marino viola"],["user_pic7","Nicholas Isley"]]
    var viewModelRobot:RobotViewModelProtocol?
    var popupViewSelected:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.viewModelRobot = RobotViewModel()
        textSearch.delegate = self
        SidePanelViewController.default.delegate = self
        tableRobot.delegate = self
        tableRobot.dataSource  =  self
        tableRobot.register(PublishRobotTableViewCell.self)
        tableRobot.register(ScheduledTableViewCell.self)
        viewSearchLogHistory.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        textSearch.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        viewModelRobot?.manager = RequestManager()
       // callGetAllWorkerRobot()
       // callGetPublishRobot()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        getRobotWorkType = digitalWorkerType.PublishRobot.rawValue
//        callGetPublishRobot()
        selectPublishRobot()
    }
    
    func setupUI(){
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewToggle.isHidden = true
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewSearchLogHistory.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        viewPublish.layer.cornerRadius = 5
        viewScheduled.layer.cornerRadius = 5
        viewInAction.layer.cornerRadius = 5
        
    }
    
    
//MARK: Button Actions
    @IBAction func buttonTap(sender: UIButton) {
        let VC = PopOverVC(nibName: "PopOver", bundle: nil)
        
        VC.modalPresentationStyle = .automatic
        VC.preferredContentSize = CGSize(width: 300, height: 200)
        self.navigationController?.present(VC, animated: true, completion: nil)
        
    }
    @IBAction func btnShowMenu(_ sender: UIButton) {
        if sender.isSelected {
            SidePanelViewController.default.hide()
            sender.isSelected = false
        }
        else {
            SidePanelViewController.default.show(on: self)
            sender.isSelected = true
        }
    }
    
    
    
    @IBAction func btnPublish(_ sender: Any) {
        selectPublishRobot()
       // tableRobot.reloadData()
    }
    
    @IBAction func btnInAction(_ sender: Any) {
        viewInAction.backgroundColor = UIColor(named: "ScheduleColor")
        viewScheduled.backgroundColor = UIColor.white
        viewPublish.backgroundColor = UIColor.white
        viewSearchLogHistory.isHidden = false
        heightConstantVwSearchLog.constant = 70.0
        viewToggle.isHidden = false
        viewSearch.isHidden = true
        getRobotWorkType = digitalWorkerType.Inaction.rawValue
        buttonAction.backgroundColor = UIColor.lightGray
        buttonLogHistory.backgroundColor = UIColor.white
        getRobotWorkType = digitalWorkerType.Inaction.rawValue
        view.endEditing(true)
       // tableRobot.reloadData()
        callGetInAction()
        
    }
    
    @IBAction func btnScheduled(_ sender: Any) {
        viewScheduled.backgroundColor = UIColor(named: "ScheduleColor")
        viewInAction.backgroundColor = UIColor.white
        viewPublish.backgroundColor = UIColor.white
        viewSearchLogHistory.isHidden = true
        heightConstantVwSearchLog.constant = 0.0
        getRobotWorkType = digitalWorkerType.Scheduled.rawValue
        view.endEditing(true)
        callGetAllWorkerRobot()
        tableRobot.reloadData()
    }
    
    @IBAction func btnAction(_ sender: Any) {
        buttonAction.backgroundColor = UIColor.lightGray
        buttonLogHistory.backgroundColor = UIColor.white
        getRobotWorkType = digitalWorkerType.Inaction.rawValue
        //tableRobot.reloadData()
        callGetInAction()
        
    }
    
    @IBAction func btnLogHistory(_ sender: Any) {
        buttonLogHistory.backgroundColor = UIColor.lightGray
        buttonAction.backgroundColor = UIColor.white
        getRobotWorkType = digitalWorkerType.LogHistory.rawValue
      //  tableRobot.reloadData()
        callLogHistory()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func selectPublishRobot(){
        viewPublish.backgroundColor = UIColor(named: "ScheduleColor")
        viewScheduled.backgroundColor = UIColor.white
        viewInAction.backgroundColor = UIColor.white
        viewSearchLogHistory.isHidden = false
        heightConstantVwSearchLog.constant = 70.0
        viewToggle.isHidden = true
        viewSearch.isHidden = false
        getRobotWorkType = digitalWorkerType.PublishRobot.rawValue
        callGetPublishRobot()
    }

}
extension RobotVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (getRobotWorkType == digitalWorkerType.Scheduled.rawValue){
           return viewModelRobot?.arraySchedule.count ?? 0
        }else if (getRobotWorkType == digitalWorkerType.Inaction.rawValue){
            return viewModelRobot?.arrayInAction.count ?? 0
        }else if (getRobotWorkType == digitalWorkerType.LogHistory.rawValue){
            return viewModelRobot?.arrayLogHistory.count ?? 0
        }
        else {
            return viewModelRobot?.arrayPublish.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (getRobotWorkType == digitalWorkerType.Scheduled.rawValue){
            let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: ScheduledTableViewCell.self), for: indexPath) as! ScheduledTableViewCell
            cell.btnRobotDetails.tag = indexPath.row
            cell.btnRobotDetails.addTarget(self, action: #selector(RobotDetails(_:)), for: .touchUpInside)
            cell.btnSchedulrDetails.addTarget(self, action: #selector(btnShowScheduledDetails(_:)), for: .touchUpInside)
            cell.btnSchedulrDetails.tag = indexPath.row
           
            cell.btnThreeDot.tag = indexPath.row

            cell.lblRobotName.text = viewModelRobot?.arraySchedule[indexPath.row].friendlyName ?? ""
            cell.lblMachineName.text = viewModelRobot?.arraySchedule[indexPath.row].machineName ?? ""
            cell.lblSchedulePeriod.text = "\(viewModelRobot?.arraySchedule[indexPath.row].scheduledPeriod ?? 0) \(viewModelRobot?.arraySchedule[indexPath.row].scheduledType ?? "")"
            cell.lblRobotType.text = viewModelRobot?.arraySchedule[indexPath.row].timeZone ?? ""
            if (viewModelRobot?.arraySchedule[indexPath.row].activeYN ?? "" == "N"){
                cell.switchActiveInActive.setOn(false, animated: true)
            }else {
                cell.switchActiveInActive.setOn(true, animated: true)
            }
            let dateTime = viewModelRobot?.arraySchedule[indexPath.row].scheduledDatetime ?? ""
            let dateTime1 = dateTime.components(separatedBy: "T")
            cell.lblScheduleDate.text = dateTime1[0]
            cell.lblScheduleTime.text = dateTime1[1]
            cell.selectionStyle = .none
            return cell
        }else {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: PublishRobotTableViewCell.self), for: indexPath) as! PublishRobotTableViewCell

//            cell.btnPauseRun.addTarget(self, action: #selector(btnpauseRun(_:)), for: .touchUpInside)
            cell.btnPauseRun.tag = indexPath.row
           // cell.btnRobotDetails.tag = indexPath.row
            cell.btn3Dot.addTarget(self, action: #selector(btnScheduleRobot(_:)), for: .touchUpInside)
            cell.btn3Dot.tag = indexPath.row
            cell.btnViewDetails.addTarget(self, action: #selector(btnShowRobotDetails(_:)), for: .touchUpInside)
            cell.btnViewDetails.tag = indexPath.row
            cell.btnQuickView.tag = indexPath.row
            cell.btnQuickView.addTarget(self, action: #selector(btnQuickViewRobot(_:)), for: .touchUpInside)
            cell.arrayPublish = viewModelRobot?.arrayPublish ?? []
            cell.arrayInAction = viewModelRobot?.arrayInAction ?? []
            cell.arrayLogHistory = viewModelRobot?.arrayLogHistory ?? []
            cell.setupCell(workerType: getRobotWorkType, Index: indexPath.row)
            cell.btnRun.addTarget(self, action: #selector(btnRunRobot(_:)), for: .touchUpInside)
            cell.btnRun.tag = indexPath.row
            cell.btnStop.addTarget(self, action: #selector(btnStopRobot(_:)), for: .touchUpInside)
            cell.btnPauseRun.addTarget(self, action: #selector(btnStopRobot(_:)), for: .touchUpInside)
            cell.btnCancelCompleted.addTarget(self, action: #selector(btnResumedRobot(_:)), for: .touchUpInside)
            cell.btnStop.tag = indexPath.row
            cell.btnPauseRun.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return UITableView.automaticDimension
    }

    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tableRobot.performBatchUpdates(nil)
        }

    }
    
    
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = self.tableRobot.cellForRow(at: indexPath) as? PublishRobotTableViewCell {
            cell.hideDetailView()
        }
        
    }
    
    
    @objc func btnStopRobot(_ sender:UIButton){
        callStopPauseRobot(taskId:viewModelRobot?.arrayInAction[sender.tag].taskID ?? "", status:"Stoped")
    }
    
    @objc func btnPauseRobot(_ sender:UIButton){
         callStopPauseRobot(taskId:viewModelRobot?.arrayInAction[sender.tag].taskID ?? "", status:"Paused")
    }
    @objc func btnResumedRobot(_ sender:UIButton){
         callStopPauseRobot(taskId:viewModelRobot?.arrayInAction[sender.tag].taskID ?? "", status:"Resumed")
    }
    
    @objc func RobotDetails(_ sender:UIButton ){
        let robotVC = RobotDetailsVC(nibName: "RobotDetailsVC", bundle: nil)
        if (getRobotWorkType == digitalWorkerType.PublishRobot.rawValue){
            robotVC.dictRobotDetails = viewModelRobot?.arrayPublish[sender.tag]
            robotVC.srtWorkerType = digitalWorkerType.PublishRobot.rawValue
          
        }else if (getRobotWorkType == digitalWorkerType.Inaction.rawValue){
            robotVC.dictRobotDetailsInAction = viewModelRobot?.arrayInAction[sender.tag]
            robotVC.srtWorkerType = digitalWorkerType.Inaction.rawValue
        }else {
           // robotVC.dictRobotLogHistory = viewModelRobot?.arrayLogHistory[sender.tag]
            robotVC.srtWorkerType = digitalWorkerType.LogHistory.rawValue
            robotVC.triggerid = viewModelRobot?.arrayLogHistory[sender.tag].triggerID
        }

        self.navigationController?.pushViewController(robotVC, animated: true)
        
    }
    @objc func btnScheduleRobot(_ sender:UIButton ){
        if (getRobotWorkType == digitalWorkerType.LogHistory.rawValue){
            callGetLogHistoryDetails(triggeredid:viewModelRobot?.arrayLogHistory[sender.tag].triggerID ?? "")
            
        }else if (getRobotWorkType == digitalWorkerType.Inaction.rawValue){
            let robotVC = RobotDetailsVC(nibName: "RobotDetailsVC", bundle: nil)
            robotVC.dictRobotDetailsInAction = viewModelRobot?.arrayInAction[sender.tag]
            robotVC.srtWorkerType = digitalWorkerType.Inaction.rawValue
            robotVC.robotimg = ""
            robotVC.robotname = viewModelRobot?.arrayInAction[sender.tag].friendlyName
            self.navigationController?.pushViewController(robotVC, animated: true)
        }
        else {
        let cell = tableRobot.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? PublishRobotTableViewCell
        if (sender.isSelected){
            cell?.viewPopUP.isHidden = true
            sender.isSelected = false
        
        }else {
            cell?.viewPopUP.isHidden = false
            sender.isSelected = true
        }
        }
    }
    @objc func btnShowScheduledDetails(_ sender:UIButton ){
        let scheduleVC = ScheduleDetailsVC(nibName: "ScheduleDetailsVC", bundle: nil)
        scheduleVC.robotimg = ""
        scheduleVC.robotname = viewModelRobot?.arraySchedule[sender.tag].userName
        scheduleVC.dictScheduleDetails = viewModelRobot?.arraySchedule[sender.tag]
        self.navigationController?.pushViewController(scheduleVC, animated: true)
        
    }
    
    @objc func btnShowRobotDetails(_ sender:UIButton){
        let scheduleVC = ScheduleDetailsVC(nibName: "ScheduleDetailsVC", bundle: nil)
        scheduleVC.robotimg = viewModelRobot?.arrayimg[sender.tag][0]
        scheduleVC.robotname = viewModelRobot?.arrayimg[sender.tag][1]
        self.navigationController?.pushViewController(scheduleVC, animated: true)
    }
    
    @objc func btnQuickViewRobot(_ sender:UIButton){
        let cell = tableRobot.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? PublishRobotTableViewCell
        cell?.viewPopUP.isHidden = true
        let robotVC = RobotDetailsVC(nibName: "RobotDetailsVC", bundle: nil)
        if (getRobotWorkType == digitalWorkerType.PublishRobot.rawValue){
            robotVC.dictRobotDetails = viewModelRobot?.arrayPublish[sender.tag]
            robotVC.srtWorkerType = digitalWorkerType.PublishRobot.rawValue
            robotVC.robotimg = viewModelRobot?.arrayPublish[sender.tag].logoPath
                //viewModelRobot?.arrayimg[sender.tag][0]
            robotVC.robotname = viewModelRobot?.arrayPublish[sender.tag].friendlyName

        }else if (getRobotWorkType == digitalWorkerType.Inaction.rawValue){
            robotVC.dictRobotDetailsInAction = viewModelRobot?.arrayInAction[sender.tag]
            robotVC.srtWorkerType = digitalWorkerType.Inaction.rawValue
            robotVC.robotimg = "" //viewModelRobot?.arrayInAction[sender.tag].logoPath
                //viewModelRobot?.arrayimg[sender.tag][0]
            robotVC.robotname = viewModelRobot?.arrayInAction[sender.tag].friendlyName
        }else {
           // robotVC.dictRobotLogHistory = viewModelRobot?.arrayLogHistory[sender.tag]
            robotVC.srtWorkerType = digitalWorkerType.LogHistory.rawValue
            robotVC.robotimg = "" //viewModelRobot?.arrayInAction[sender.tag].logoPath
                //viewModelRobot?.arrayimg[sender.tag][0]
            robotVC.robotname = viewModelRobot?.arrayLogHistory[sender.tag].robotName
        }

       // robotVC.RobotDetails = viewModelRobot?.arrayPublish[sender.tag]
        self.navigationController?.pushViewController(robotVC, animated: true)
        
    }
    
    @objc func btnRunRobot(_ sender:UIButton) {
        if let userid = UserDefaults.standard.value(forKey: "USERID") {
            callRunRobotApi(publishedScriptID: viewModelRobot?.arrayPublish[sender.tag].publishedScriptID ?? "", ClientID: viewModelRobot?.arrayPublish[sender.tag].clientID ?? "", workerID: viewModelRobot?.arrayPublish[sender.tag].workerID ?? "", MachineKey: viewModelRobot?.arrayPublish[sender.tag].machineKey ?? "", RunByUserID: userid as? String)
        }

    }

}

extension RobotVC:SidePanelDelegate {
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
   
}


extension RobotVC:UITextFieldDelegate{
    @objc func textFieldValueChange(_ txt: UITextField)  {
        searchItem = txt.text!
        
        if (searchItem != ""){
            
            viewModelRobot?.searchRobotString = searchItem
            viewModelRobot?.getSearchRobotName(completion: { (result) in
                switch result {
                case .success(let result):
                    if let success = result as? Bool , success == true {
                        DispatchQueue.main.async {
                             self.tableRobot.reloadData()
                        }
                        
                    }
                case .failure( _): break
               }
            })
            
        }else {
            self.viewModelRobot?.arrayPublish = viewModelRobot?.arrayPublishDataStore ?? []
            
        }
        self.tableRobot.reloadData()
    }
    
}
// MARK:- Api Call

extension RobotVC {
    func callGetAllWorkerRobot(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelRobot?.callScheduleRobot( completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    
                    self.tableRobot.reloadData()
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
    
    func callGetPublishRobot(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelRobot?.callPublishRobot( completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    
                    self.tableRobot.reloadData()
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
    func callGetInAction(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelRobot?.callInActionRobot( completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    
                    self.tableRobot.reloadData()
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
    
    func callLogHistory(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelRobot?.callLogHistory( completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    
                    self.tableRobot.reloadData()
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
    
    func callGetLogHistoryDetails(triggeredid:String){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelRobot?.callLogHistoryRobotDetails(triggeredId:triggeredid ,completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {

                    DispatchQueue.main.async {
                        hideActivityIndicator(viewController: self)
                        let robotVC = RobotDetailsVC(nibName: "RobotDetailsVC", bundle: nil)
                        robotVC.dictRobotLogHistory = self.viewModelRobot?.arrayLogHistoryDetails[0]
                        robotVC.srtWorkerType = digitalWorkerType.LogHistory.rawValue
                        robotVC.robotimg = ""
                        robotVC.robotname = self.viewModelRobot?.arrayLogHistoryDetails[0].friendlyName ?? ""
                        robotVC.triggerid = triggeredid
                        self.navigationController?.pushViewController(robotVC, animated: true)
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
    
    func callRunRobotApi(publishedScriptID:String?,ClientID:String?,workerID:String?,MachineKey:String?,RunByUserID:String?){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelRobot?.callRunRobot(publishedScriptID:publishedScriptID,ClientID:ClientID,workerID:workerID,MachineKey:MachineKey,RunByUserID:RunByUserID, completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {

                    DispatchQueue.main.async {
                        hideActivityIndicator(viewController: self)

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
    
   func callStopPauseRobot(taskId:String, status:String){
        viewModelRobot?.callStopPauseRobot(taskId: taskId, status: status, completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {

                    DispatchQueue.main.async {
                        hideActivityIndicator(viewController: self)

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
