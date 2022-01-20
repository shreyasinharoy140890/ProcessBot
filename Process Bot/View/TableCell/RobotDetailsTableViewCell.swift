//
//  RobotDetailsTableViewCell.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 26/07/21.
//

import UIKit

class RobotDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPostDetails: UILabel!
    @IBOutlet weak var lblPostName: UILabel!
    @IBOutlet weak var viewpostName: UIView!
    @IBOutlet weak var viewPost: UIView!
    
    var dictPublishDetails:PublishedRobotModel?
    var dictInActionDetails:InActionModel?
    var dictLogHistory:robitDetailsModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellSetup(index:Int,workerType:String){
        
        if (index % 2 == 0) {
            viewPost.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
            viewpostName.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
        }else {
            viewPost.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
            viewpostName.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
           
        }
        if workerType == digitalWorkerType.PublishRobot.rawValue {
        switch index{
        case 0: lblPostDetails.text = dictPublishDetails?.publishedScriptID
        case 1: lblPostDetails.text = dictPublishDetails?.machineName
        case 2: lblPostDetails.text = dictPublishDetails?.workerName
        case 3: lblPostDetails.text = dictPublishDetails?.friendlyName
        case 4: lblPostDetails.text = "\(dictPublishDetails?.totMinute ?? 0)"
        case 5: lblPostDetails.text = dictPublishDetails?.lastRunStatus
        case 6: lblPostDetails.text = dictPublishDetails?.version
        case 7: lblPostDetails.text = dictPublishDetails?.publishedOn
        case 8: lblPostDetails.text = dictPublishDetails?.robotType

        default:
            break
        }
        }
    
    else if workerType == digitalWorkerType.Inaction.rawValue {
        switch index{
        case 0: lblPostDetails.text = dictInActionDetails?.publishedScriptID
        case 1: lblPostDetails.text = dictInActionDetails?.machineName
        case 2: lblPostDetails.text = dictInActionDetails?.workerName
        case 3: lblPostDetails.text = dictInActionDetails?.friendlyName
        case 4: lblPostDetails.text = "\(dictInActionDetails?.taskStarted ?? "")"
        case 5: lblPostDetails.text = dictInActionDetails?.currentStaus
        case 6: lblPostDetails.text = dictInActionDetails?.version
        case 7: lblPostDetails.text = dictInActionDetails?.publishedOn
        case 8: lblPostDetails.text = dictInActionDetails?.robotType
      
        default:
            break
        }
    }else {
       
        
        switch index{
        case 0: lblPostDetails.text = dictLogHistory?.publishedScriptID
        case 1: lblPostDetails.text = dictLogHistory?.machineName
        case 2: lblPostDetails.text = dictLogHistory?.workerName
        case 3: lblPostDetails.text = dictLogHistory?.friendlyName
        case 4: lblPostDetails.text = "\(dictLogHistory?.executionTime ?? "")"
        case 5: lblPostDetails.text = dictLogHistory?.currentStaus
        case 6: lblPostDetails.text = dictLogHistory?.version
        case 7: lblPostDetails.text = dictLogHistory?.publishedOn
        case 8: lblPostDetails.text = dictLogHistory?.robotType

        default:
            break
        }
    
    }
    }
    
}
