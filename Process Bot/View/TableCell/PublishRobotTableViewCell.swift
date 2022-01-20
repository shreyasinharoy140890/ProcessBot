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
    
    @IBOutlet weak var viewDetails: UIView!
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
    
    @IBOutlet weak var btnViewDetails: UIButton!
    @IBOutlet weak var viewPopUP: UIView!
    @IBOutlet weak var btnRun: UIButton!
    @IBOutlet weak var btnQuickView: UIButton!
    @IBOutlet weak var btnAddParameter: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var btnPauseRun: UIButton!
    
    @IBOutlet weak var btnCancelCompleted: UIButton!
    
    @IBOutlet weak var lblProcessName: UILabel!
    @IBOutlet weak var lblHostName: UILabel!
    @IBOutlet weak var lblRobotType: UILabel!
    
    @IBOutlet weak var lblHeader1: UILabel!
    @IBOutlet weak var lblHeader2: UILabel!
    @IBOutlet weak var lblheader3: UILabel!
    
    @IBOutlet weak var viewProgressBar: CircularProgressBar!
    
    
    var arrayPublish:[PublishedRobotModel]?
    var arrayInAction:[InActionModel]?
    var arrayLogHistory:[logHistoryModel]?
    var currentTime:Double = 0
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //stackVwDetail.isHidden = true
        viewDetails.isHidden = true
        imgStop.isHidden = true
        lblStop.isHidden = true
        imgCancel.isHidden = true
        lblCancel.isHidden = true
        viewPopUP.addShadow(offset: CGSize.init(width: 0, height: 1), color: .black, radius: 2, opacity: 0.7)
        viewPopUP.isHidden = true
        viewProgressBar.safePercent = 100
        viewProgressBar.lineColor = UIColor(named: "ScheduleColor")!
        viewProgressBar.lineFinishColor = UIColor(named: "ScheduleColor")!
        viewProgressBar.lineBackgroundColor = .lightGray
       // handleTap()
       // viewStop.isHidden = true
        // Initialization code
        self.viewProgressBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        viewProgressBar.setProgress(to: 1, withAnimation: true)
    }


    func setupCell(workerType:String, Index:Int){
     //   imgRobot.image = UIImage(named: arrayimg[Index][0])
        
        if workerType == digitalWorkerType.PublishRobot.rawValue {
            imgStop.isHidden = true
            lblStop.isHidden = true
            imgPause.isHidden = false
            lblPause.isHidden = false
            lblPause.text = arrayPublish?[Index].currentStaus ?? ""
            imgPause.image = UIImage(named: "play_icon")
          //  imgthreeDotEye.image = UIImage(named: "menu")
            imgCancel.image = UIImage(named: "cancel_icon")
            lblCancel.text = "Cancel"
            imgCancel.isHidden = true
            lblCancel.isHidden = true
            let name = arrayPublish?[Index].friendlyName ?? ""
            let name1 = name.components(separatedBy: ".")
            lblRobotName.text = name1[0]
            lblHostName.text = arrayPublish?[Index].machineName ?? ""
            lblRobotType.text = arrayPublish?[Index].robotType ?? ""
            lblProcessName.text = arrayPublish?[Index].processName ?? ""
            lblHeader1.text = "Process name"
            lblHeader2.text = "Host name"
            lblheader3.text = "Robot Type"
            if (arrayPublish?[Index].logoPath == ""){
                imgRobot.image = UIImage(named: "robot_circle_icon")
            }else {
            imgRobot.downloaded(from: arrayPublish?[Index].logoPath ?? "")
            }
            viewProgressBar.isHidden = true
        }else if workerType == digitalWorkerType.Inaction.rawValue {
            imgStop.isHidden = false
            lblStop.isHidden = false
            imgPause.isHidden = false
            lblPause.isHidden = false
            imgCancel.image = UIImage(named: "resume_icon")
            lblCancel.text = "Resume"
         //   imgthreeDotEye.image = UIImage(named: "dotted_icon_up")
            imgCancel.isHidden = false
            lblCancel.isHidden = false
            let name = arrayInAction?[Index].friendlyName ?? ""
           let name1 = name.components(separatedBy: ".")
            lblRobotName.text = name1[0]
            lblHostName.text = arrayInAction?[Index].machineName ?? ""
            lblRobotType.text = arrayInAction?[Index].robotType ?? ""
            lblProcessName.text = arrayInAction?[Index].currentStaus ?? ""
            lblHeader1.text = "Status"
            lblHeader2.text = "Host name"
            lblheader3.text = "Robot Type"
            imgRobot.image = UIImage(named: "robot_circle_icon")
            viewProgressBar.isHidden = false
            var currentTime:Double = 0
            let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
                if currentTime >= 2 {
                    timer.invalidate()
                } else {
                    currentTime += 0.05
                    let percent = currentTime/2 * 100
                   // self.lblRobotName.text =
                        //"\(Int(self.viewProgressBar.progress ?? 0.0 * percent))"
                        //self.viewProgressBar.label.text
                        //"\(Int(progress * percent))"
                    //self.setForegroundLayerColorForSafePercent()
                    //self.configLabel()
                }
            }
            timer.fire()
            
       // }
//            currentTime += 0.05
//            let percent = currentTime/2 * 100
         //   lblRobotName.text = viewProgressBar.label.text ?? ""
                //"\(Int(viewProgressBar.progress ?? 0.0 * percent))"
                //viewProgressBar.progr
                //"\(Int(viewProgressBar. * percent))"
            
        }
        else if workerType == digitalWorkerType.LogHistory.rawValue {
            imgStop.isHidden = true
            lblStop.isHidden = true
            imgPause.isHidden = true
            lblPause.isHidden = true
            imgCancel.isHidden = false
            lblCancel.isHidden = false
            imgCancel.image = UIImage(named: "resume_icon")
            lblCancel.text = arrayLogHistory?[Index].eventStatus ?? ""
            //imgthreeDotEye.image = UIImage(named: "view_icon")
            let name = arrayLogHistory?[Index].robotName ?? ""
            let name1 = name.components(separatedBy: ".")
            lblRobotName.text = name1[0]
            lblHostName.text = arrayLogHistory?[Index].hostName ?? ""
            lblRobotType.text = arrayLogHistory?[Index].eventRaiseBy ?? ""
            lblProcessName.text = arrayLogHistory?[Index].eventTime ?? ""
            lblHeader1.text = "Event Time"
            lblHeader2.text = "Host name"
            lblheader3.text = "Triggered By"
            imgRobot.image = UIImage(named: "robot_circle_icon")
            viewProgressBar.isHidden = true
            
        }
    
    }
    var isDetailViewHidden: Bool {
        return viewDetails.isHidden
    }

    func showDetailView() {
        viewDetails.isHidden = false
    }

    func hideDetailView() {
        viewDetails.isHidden = true
        viewPopUP.isHidden = true
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
