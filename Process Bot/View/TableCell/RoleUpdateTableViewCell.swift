//
//  RoleUpdateTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 28/09/21.
//

import UIKit

class RoleUpdateTableViewCell: UITableViewCell {
    @IBOutlet weak var viewroleName: UIView!
    
    @IBOutlet weak var viewsubMenu: UIView!
    
    @IBOutlet weak var viewEdit: UIView!
    
    @IBOutlet weak var viewDelete: UIView!
    
    @IBOutlet weak var labelroleName: UILabel!
    
    @IBOutlet weak var buttonView: UIButton!
    
    @IBOutlet weak var buttonAdd: UIButton!
    
    @IBOutlet weak var buttonDelete: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellSetup(index:Int){
        
        if (index % 2 == 0) {
            viewroleName.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
            viewsubMenu.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
            viewEdit.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
            viewDelete.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
            
        }else {
          
            viewroleName.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
            viewsubMenu.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
            viewEdit.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
            viewDelete.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
            
           
        }
        
}
}
