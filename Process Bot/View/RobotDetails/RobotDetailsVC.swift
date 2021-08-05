//
//  RobotDetailsVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 26/07/21.
//

import UIKit

class RobotDetailsVC: UIViewController {
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var viewRobotDetails: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tableRobotDetails: UITableView!
    @IBOutlet weak var imgRobot: UIImageView!
    @IBOutlet weak var lblRobotName: UILabel!
    
    
    var arrayDetails = [["Event ID","678FGBRGB-787bhfbgvh"],["Host name","678FGBRGB"],["User Name","Worker2"],["Robot Name","Stock-Journal"],["Event Execution time","2hr,2min,10secs"],["Status","Completed"],["Robot Type","Attended"]]
    var robotimg:String?
    var robotname:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        SidePanelViewController.default.delegate = self
        tableRobotDetails.delegate = self
        tableRobotDetails.dataSource = self
        tableRobotDetails.register(RobotDetailsTableViewCell.self)
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        tableRobotDetails.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        imgRobot.image = UIImage(named: robotimg ?? "")
        lblRobotName.text = robotname ?? ""

        // Do any additional setup after loading the view.
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
        cell.lblPostDetails.text = arrayDetails[indexPath.row][1]
        if (indexPath.row % 2 == 0) {
            cell.viewPost.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
            cell.viewpostName.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
        }else {
            cell.viewPost.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
            cell.viewpostName.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
           // cell.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
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
