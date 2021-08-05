//
//  ScheduledTableViewCell.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 28/07/21.
//

import UIKit

class ScheduledTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRobotName: UILabel!
    @IBOutlet weak var imgRobot: UIImageView!
    @IBOutlet weak var btnRobotDetails: UIButton!
    @IBOutlet weak var btnThreeDot: UIButton!
    @IBOutlet weak var viewRobot: UIView!
    @IBOutlet weak var stackvwWorkOption: UIStackView!
    
    var arrayimg = [["user_pic1","David Thomas"],["user_pic2","William corry"],["user_pic3","Jhon deo"],["user_pic4","Bill gates"],["user_pic5","William corry"],["user_pic","Marino"],["user_pic7","Nichole"],["user_pic2","William corry"],["user_pic3","William corry"]]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stackvwWorkOption.isHidden = true
    }
    var isDetailViewHidden: Bool {
        return stackvwWorkOption.isHidden
    }

    func showDetailView() {
        stackvwWorkOption.isHidden = false
    }

    func hideDetailView() {
        stackvwWorkOption.isHidden = true
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
