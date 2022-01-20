//
//  ScheduledTableViewCell.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 28/07/21.
//

import UIKit

class ScheduledTableViewCell: UITableViewCell {

  
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var lblRobotName: UILabel!
    @IBOutlet weak var imgRobot: UIImageView!
    @IBOutlet weak var btnRobotDetails: UIButton!
    @IBOutlet weak var btnThreeDot: UIButton!
    @IBOutlet weak var viewRobot: UIView!
    @IBOutlet weak var stackvwWorkOption: UIStackView!
    
    @IBOutlet weak var switchActiveInActive: UISwitch!
    
    @IBOutlet weak var lblRobotType: UILabel!
    @IBOutlet weak var lblMachineName: UILabel!
    @IBOutlet weak var lblSchedulePeriod: UILabel!
    
    @IBOutlet weak var lblScheduleTime: UILabel!
    @IBOutlet weak var lblScheduleDate: UILabel!
    @IBOutlet weak var btnSchedulrDetails: UIButton!
    
    
    var arrayimg = [["user_pic1","David Thomas"],["user_pic2","William corry"],["user_pic3","Jhon deo"],["user_pic4","Bill gates"],["user_pic5","William corry"],["user_pic","Marino"],["user_pic7","Nichole"],["user_pic2","William corry"],["user_pic3","William corry"]]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // stackvwWorkOption.isHidden = true
        viewDetails.isHidden = true
//        viewPopUP.addShadow(offset: CGSize.init(width: 0, height: 1), color: .black, radius: 2, opacity: 0.7)
//        viewPopUP.isHidden = true
    }
    var isDetailViewHidden: Bool {
        return viewDetails.isHidden
    }

    func showDetailView() {
        viewDetails.isHidden = false
    }

    func hideDetailView() {
        viewDetails.isHidden = true
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
