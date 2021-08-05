//
//  RobotVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 26/07/21.
//

import UIKit

class RobotVC: UIViewController,UITextFieldDelegate {
    
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
    
    
    
    var setIndex = Set<Int>()
    var getRobotWorkType:String = ""
    var arrayimg = [["user_pic1","David Thomas"],["user_pic2","William corry"],["user_pic3","Jhon deo"],["user_pic4","Bill gates"],["user_pic5","William corry"],["user_pic6","Marino"],["user_pic7","Nichole"],["user_pic2","William corry"],["user_pic3","William corry"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        textSearch.delegate = self
        SidePanelViewController.default.delegate = self
        tableRobot.delegate = self
        tableRobot.dataSource  =  self
        tableRobot.register(PublishRobotTableViewCell.self)
        tableRobot.register(ScheduledTableViewCell.self)
        viewSearchLogHistory.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
      

        // Do any additional setup after loading the view.
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
        viewPublish.backgroundColor = UIColor(named: "ScheduleColor")
        viewScheduled.backgroundColor = UIColor.white
        viewInAction.backgroundColor = UIColor.white
        viewSearchLogHistory.isHidden = false
        heightConstantVwSearchLog.constant = 70.0
        viewToggle.isHidden = true
        viewSearch.isHidden = false
        getRobotWorkType = digitalWorkerType.PublishRobot.rawValue
        tableRobot.reloadData()
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
        view.endEditing(true)
        tableRobot.reloadData()
        
    }
    
    @IBAction func btnScheduled(_ sender: Any) {
        viewScheduled.backgroundColor = UIColor(named: "ScheduleColor")
        viewInAction.backgroundColor = UIColor.white
        viewPublish.backgroundColor = UIColor.white
        viewSearchLogHistory.isHidden = true
        heightConstantVwSearchLog.constant = 0.0
        getRobotWorkType = digitalWorkerType.Scheduled.rawValue
        view.endEditing(true)
        tableRobot.reloadData()
    }
    
    @IBAction func btnAction(_ sender: Any) {
        buttonAction.backgroundColor = UIColor.lightGray
        buttonLogHistory.backgroundColor = UIColor.white
        getRobotWorkType = digitalWorkerType.Inaction.rawValue
        tableRobot.reloadData()
        
    }
    
    @IBAction func btnLogHistory(_ sender: Any) {
        buttonLogHistory.backgroundColor = UIColor.lightGray
        buttonAction.backgroundColor = UIColor.white
        getRobotWorkType = digitalWorkerType.LogHistory.rawValue
        tableRobot.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
extension RobotVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (getRobotWorkType == digitalWorkerType.Scheduled.rawValue){
            let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: ScheduledTableViewCell.self), for: indexPath) as! ScheduledTableViewCell
            cell.btnRobotDetails.tag = indexPath.row
            cell.btnRobotDetails.addTarget(self, action: #selector(RobotDetails(_:)), for: .touchUpInside)
            cell.btnThreeDot.addTarget(self, action: #selector(btnScheduleRobot(_:)), for: .touchUpInside)
            cell.btnThreeDot.tag = indexPath.row
            cell.imgRobot.image = UIImage(named: arrayimg[indexPath.row][0])
            cell.lblRobotName.text = arrayimg[indexPath.row][1]
           
            cell.selectionStyle = .none
            return cell
        }else {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: PublishRobotTableViewCell.self), for: indexPath) as! PublishRobotTableViewCell
            cell.btnRobotDetails.addTarget(self, action: #selector(RobotDetails(_:)), for: .touchUpInside)
            cell.btnRobotDetails.tag = indexPath.row
            cell.btn3Dot.addTarget(self, action: #selector(btnScheduleRobot(_:)), for: .touchUpInside)
            cell.btn3Dot.tag = indexPath.row
        cell.setupCell(workerType: getRobotWorkType, Index: indexPath.row)
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
    
    @objc func RobotDetails(_ sender:UIButton ){
        let robotVC = RobotDetailsVC(nibName: "RobotDetailsVC", bundle: nil)
        robotVC.robotimg = arrayimg[sender.tag][0]
        robotVC.robotname = arrayimg[sender.tag][1]
        self.navigationController?.pushViewController(robotVC, animated: true)
        
    }
    @objc func btnScheduleRobot(_ sender:UIButton ){
        let scheduleVC = ScheduleDetailsVC(nibName: "ScheduleDetailsVC", bundle: nil)
        scheduleVC.robotimg = arrayimg[sender.tag][0]
        scheduleVC.robotname = arrayimg[sender.tag][1]
        self.navigationController?.pushViewController(scheduleVC, animated: true)
    }
    
    
  
    
    
}

extension RobotVC:SidePanelDelegate {
   
    
    
    
    
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    
    
    
    
}
