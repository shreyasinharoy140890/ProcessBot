//
//  ScheduleDetailsVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 15/07/21.
//

import UIKit

class ScheduleDetailsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblRobotName: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imgRobot: UIImageView!
    var arrayDetails = [["Host Name","678FGBRGB-787bhfbgvh"],["User name","RobotServer3"],["Execution Type","Remote"],["Scheduled By","Jhon"],["Scheduled Period","1"],["Status","Scheduled"],["WorkDayName","Monday,Friday"],["Scheduled DateTime","Feb 17th,1pm"],["Next Run dateTime","july 22,2pm"],["Robot Name ","New Employee",],["Time Zone","IST"],["Remark","Scheduled by Intelgic"],["OS Type","Server"]]
    var robotimg:String?
    var robotname:String?
    var dictScheduleDetails:ScheduleModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ScheduleCollectionViewCell.self)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        collectionView!.collectionViewLayout = layout
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        if (robotimg == ""){
            imgRobot.image = UIImage(named: "robot_circle_icon")
        }else {
            imgRobot.image = UIImage(named: robotimg ?? "")
        }
        
        lblRobotName.text = robotname ?? ""
        // Do any additional setup after loading the view.
        if let _ = dictScheduleDetails {
            collectionView.reloadData()
        }
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    


}

extension ScheduleDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ScheduleCollectionViewCell.self), for: indexPath) as! ScheduleCollectionViewCell
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
        }else {
            cell.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
        }
        cell.lblScheduledName.text = arrayDetails[indexPath.row][0]
        switch indexPath.row {
        case 0: cell.lblScheduledDetails.text = dictScheduleDetails?.machineName ?? ""
        case 1: cell.lblScheduledDetails.text = dictScheduleDetails?.userName ?? ""
        case 2: cell.lblScheduledDetails.text = dictScheduleDetails?.executionType ?? ""
        case 3: cell.lblScheduledDetails.text = dictScheduleDetails?.scheduledBy ?? ""
        case 4: cell.lblScheduledDetails.text = "\(dictScheduleDetails?.scheduledPeriod ?? 1)"
        case 5: cell.lblScheduledDetails.text = dictScheduleDetails?.status ?? ""
        case 6: cell.lblScheduledDetails.text = dictScheduleDetails?.weekDayName ?? ""
        case 7: cell.lblScheduledDetails.text = dictScheduleDetails?.scheduledDatetime ?? ""
        case 8: cell.lblScheduledDetails.text = dictScheduleDetails?.nextRunTime ?? ""
        case 9: cell.lblScheduledDetails.text = dictScheduleDetails?.friendlyName ?? ""
        case 10: cell.lblScheduledDetails.text = dictScheduleDetails?.timeZone ?? ""
        case 11: cell.lblScheduledDetails.text = dictScheduleDetails?.remark ?? ""
        case 12: cell.lblScheduledDetails.text = dictScheduleDetails?.oSType ?? ""
        default:
            cell.lblScheduledDetails.text = arrayDetails[indexPath.row][1]
        }
       // cell.lblScheduledDetails.text = arrayDetails[indexPath.row][1]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width )/3, height: (collectionView.frame.width)/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 0
            }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 0
            }
    
}

