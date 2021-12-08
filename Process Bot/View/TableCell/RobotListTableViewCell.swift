//
//  RobotListTableViewCell.swift
//  Process Bot
//
//  Created by Appsbee on 08/12/21.
//

import UIKit

class RobotListTableViewCell: UITableViewCell {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var buttonselect: UIButton!
    @IBOutlet weak var labelrobotName: UILabel!
    @IBOutlet weak var labelversionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellSetup(index:Int){
        
        if (index % 2 == 0) {
            viewMain.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
           
        }else {
          
            viewMain.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
           
            
           
        }
     
}
}
