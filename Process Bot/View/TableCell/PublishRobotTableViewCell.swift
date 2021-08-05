//
//  PublishRobotTableViewCell.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 26/07/21.
//

import UIKit

class PublishRobotTableViewCell: UITableViewCell {
    @IBOutlet weak var viewRobotName: UIView!
    
    @IBOutlet weak var lblRobotName: UILabel!
    @IBOutlet weak var stackVwDetail: UIStackView!
    @IBOutlet weak var imgRobot: UIImageView!
    
    @IBOutlet weak var lblPause: UILabel!
    @IBOutlet weak var imgPause: UIImageView!
    @IBOutlet weak var viewStop: UIView!
    @IBOutlet weak var viewCancel: UIView!
    @IBOutlet weak var viewPause: UIView!
    @IBOutlet weak var imgCancel: UIImageView!
    @IBOutlet weak var lblCancel: UILabel!
    @IBOutlet weak var imgStop: UIImageView!
    @IBOutlet weak var lblStop: UILabel!
    @IBOutlet weak var imgthreeDotEye: UIImageView!
    @IBOutlet weak var btn3Dot: UIButton!
    @IBOutlet weak var btnRobotDetails: UIButton!
    var arrayimg = [["user_pic1","David Thomas"],["user_pic2","William corry"],["user_pic3","Jhon deo"],["user_pic4","Bill gates"],["user_pic5","William corry"],["user_pic6","Marino"],["user_pic7","Nichole"],["user_pic2","William corry"],["user_pic3","William corry"]]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackVwDetail.isHidden = true
        imgStop.isHidden = true
        lblStop.isHidden = true
       // viewStop.isHidden = true
        // Initialization code
    }


    func setupCell(workerType:String, Index:Int){
        imgRobot.image = UIImage(named: arrayimg[Index][0])
        lblRobotName.text = arrayimg[Index][1]
        if workerType == digitalWorkerType.PublishRobot.rawValue {
            imgStop.isHidden = true
            lblStop.isHidden = true
            imgPause.isHidden = false
            lblPause.isHidden = false
            imgthreeDotEye.image = UIImage(named: "dotted_icon")
            imgCancel.image = UIImage(named: "cancel_icon")
            lblCancel.text = "Cancel"
        }else if workerType == digitalWorkerType.Inaction.rawValue {
            imgStop.isHidden = false
            lblStop.isHidden = false
            imgPause.isHidden = false
            lblPause.isHidden = false
            imgCancel.image = UIImage(named: "resume_icon")
            lblCancel.text = "Resume"
            imgthreeDotEye.image = UIImage(named: "dotted_icon")
        }
        else if workerType == digitalWorkerType.LogHistory.rawValue {
            imgStop.isHidden = true
            lblStop.isHidden = true
            imgPause.isHidden = true
            lblPause.isHidden = true
            imgCancel.image = UIImage(named: "resume_icon")
            lblCancel.text = "Completed"
            imgthreeDotEye.image = UIImage(named: "view_icon")
            
        }
    
    }
    var isDetailViewHidden: Bool {
        return stackVwDetail.isHidden
    }

    func showDetailView() {
        stackVwDetail.isHidden = false
    }

    func hideDetailView() {
        stackVwDetail.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
    
}
