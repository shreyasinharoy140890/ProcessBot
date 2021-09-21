//
//  SidePanelViewController.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 15/07/21.
//

import UIKit

protocol SidePanelDelegate:class {
    func didDisplayMenu(status:Bool)
    
}

class SidePanelViewController: UIViewController,AlertDisplayer {
    
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblEmailofUser: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblNameOfUser: UILabel!
    @IBOutlet weak var tableSidePanelList: UITableView!
    
    
    static let `default` = SidePanelViewController()
    var delegate: SidePanelDelegate?

    var expandedSections : NSMutableSet = []
    var sectionData :[String] = ["Digital Worker","Process","Cognitive Bot","Administrative","Machine / Bot","Dashboard","Logout"]
    
    var sectionImageData:[UIImage] = [UIImage(named: "robot_icon")!,UIImage(named: "process_icon")!, UIImage(named: "cognative_icon")!, UIImage(named: "administrative_icon")!, UIImage(named: "machine_hos_icon")!, UIImage(named: "dashboard_icon"
)!, UIImage(named: "logout_icon")!]
    
    
    var row3 = ["User Management","Company Profile","Assignment","Role Management","Directory"]
    var imagerow3:[UIImage] = [UIImage(named: "usermanagement")!,UIImage(named: "companyprofile")!, UIImage(named: "assignment")!, UIImage(named: "rolemanagement")!,UIImage(named: "directory")!]
    
    var row4 = ["Stand- Alone","Server"]
    var imagerow4:[UIImage] = [UIImage(named:"standalonehost")!, UIImage(named:"server")!]
    
   override func viewDidLoad() {
        super.viewDidLoad()
    tableSidePanelList.delegate = self
    tableSidePanelList.dataSource = self
    tableSidePanelList.register(SidePanelTableViewCell.self)
    viewShadow.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addUserInfo()
        print(sectionData)
        tableSidePanelList.delegate = self
        tableSidePanelList.dataSource = self
        tableSidePanelList.register(SidePanelTableViewCell.self)
        tableSidePanelList.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
      //  tableSidePanelList.reloadData()
        }
    
    
    @objc func sectionTapped(_ sender: UIButton) {
        //print("section Tapped")
        let section = sender.tag
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.add(section)
        } else {
           
            expandedSections.removeAllObjects()
        }
        if section == 0
        {
            let VC = RobotVC(nibName: "RobotVC", bundle: nil)
            UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)
            
        }
     else   if section == 5
        {
            let VC = DashboardVC(nibName: "DashboardVC", bundle: nil)
            UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)
            
        }
    else if section == 6
    {
        logout()
    }


        self.tableSidePanelList.reloadData()
    }
    
    
    func show(on parent:UIViewController) {
        delegate?.didDisplayMenu(status: true)
        self.view.frame.origin.x = 0
        parent.addChild(self)
        
        // Left To Right Animation
        CATransaction.begin()
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
        transition.delegate = self
        self.view.layer.add(transition, forKey: nil)
        
        parent.view.addSubview(self.view)
        self.didMove(toParent: parent)
        CATransaction.commit()
        tableSidePanelList.reloadData()
    }
    
    
    func hide(handler: ((Bool) -> Void)? = nil) {
        delegate?.didDisplayMenu(status: false)
      //  self.view.backgroundColor = .clear
        
        // Right To Left Animation
        #if swift(>=5.3)
        //print("Swift 5.3")
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn) {
            
            self.view.frame.origin.x -= UIScreen.main.bounds.width
            
        } completion: { (success) in
            self.willMove(toParent: nil)
            self.removeFromParent()
            self.view.removeFromSuperview()
            handler?(success)
        }
        // Xcode 11.3.1 = Swift version 5.1.3
        // https://en.wikipedia.org/wiki/Xcode#Xcode_7.0_-_12.x_(since_Free_On-Device_Development)
        #elseif swift(<5.3)
        //print("Prior Swift of 5.3")
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            var rect:CGRect = self.view.frame
            rect.origin.x -= UIScreen.main.bounds.width
            self.view.frame = rect
        }) { (success) in
            self.willMove(toParent: nil)
            self.removeFromParent()
            self.view.removeFromSuperview()
            handler?(success)
        }
        #endif
    }

    @IBAction func btnHideSidePanel(_ sender: Any) {
        hide()
    }
    
    func addUserInfo(){
        if let name = UserDefaults.standard.value(forKey: "FULLNAME") {
            lblNameOfUser.text = name as? String
        }
        if let email = UserDefaults.standard.value(forKey: "EMAIL") {
            lblEmailofUser.text = email as? String
        }
    }
 
}

extension SidePanelViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
        var imageView = UIImageView()
        if (expandedSections.contains(section)) {
            imageView = UIImageView.init(frame: CGRect(x: 200, y: 25, width: 18, height: 10))
            imageView.image = UIImage(named: "down-arrow")
        } else {
            imageView = UIImageView.init(frame: CGRect(x: 210, y: 25, width: 10, height: 18))
            imageView.image = UIImage(named: "right-arrow")
        }
        
        let headerTitle = UILabel.init(frame: CGRect(x: 70, y: 12, width: 250, height: 35))
        headerTitle.text = sectionData[section]
        headerTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        let headerimageView = UIImageView()
        headerimageView.frame = CGRect(x: 15, y: 10, width: 30, height: 30)
        headerimageView.image = sectionImageData[section]
        let tappedSection = UIButton.init(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width , height: headerView.frame.size.height))
        
        tappedSection.addTarget(self, action: #selector(sectionTapped), for: .touchUpInside)
        tappedSection.tag = section
        
        if section == 3 || section == 4
        {
            headerView.addSubview(imageView)
        }
      
      
        headerView.addSubview(headerTitle)
        headerView.addSubview(headerimageView)
        headerView.addSubview(tappedSection)
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
//            case 0:
//                return 0
//            case 1:
//                return 0
//            case 2:
//                return 0
            case 3 :
                return row3.count
            case 4:
                return row4.count
//            case 5:
//                return 0
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: SidePanelTableViewCell.self), for: indexPath) as! SidePanelTableViewCell
        
        cell.selectionStyle = .none
        switch indexPath.section {

        case 3:
            cell.lblMenu?.text = "\(row3[indexPath.row])"
            cell.imageView?.image = imagerow3[indexPath.row]
            return cell
        case 4:
            cell.lblMenu?.text = "\(row4[indexPath.row])"
            cell.imageView?.image = imagerow4[indexPath.row]
            return cell
            
        default:
            cell.lblMenu?.text = "\(row4[indexPath.row])"
            cell.imageView?.image = imagerow4[indexPath.row]
           return cell
        }
     
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
           
                           let VC = RobotVC(nibName: "RobotVC", bundle: nil)
                           UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)
           
                    
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = ""
        
        switch indexPath.section {
        case 0 :
            
           
                let VC = RobotVC(nibName: "RobotVC", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)

        case 1 :
            print(indexPath.section)
        
        
        case 3:
            
            item = row3[indexPath.row]
            if indexPath.row == 0
            {
                let VC = UserManagementViewController(nibName: "UserManagementViewController", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)

            }
            else if  indexPath.row == 1
            {
                let VC = CompanyProfileVC(nibName: "CompanyProfileVC", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)
            }
        case 4:
            
            item = row4[indexPath.row]
            if indexPath.row == 0
            {
                let VC = StandAloneVC(nibName: "StandAloneVC", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)

            }
            else
            {
                let VC = ServerVC(nibName: "ServerVC", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)
            }
            
            
        default:
            item = row4[indexPath.row]
        }
        
      

            self.tableSidePanelList.reloadRows(at: [indexPath], with: .automatic)
       
    }
    

    func logout() {
      let alertOkAction = UIAlertAction(title: "YES".localized(), style: .default) { (_) in
            
            let defaults = UserDefaults.standard
            defaults.synchronize()
            defaults.removeObject(forKey: "USERID")
            defaults.removeObject(forKey: "EMAIL")
            defaults.removeObject(forKey: "CLIENTID")
            defaults.removeObject(forKey: "FULLNAME")
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            // UserDefaults.standard.synchronize()
//            let manager = LoginManager()
//            manager.logOut()
            if let loginVC = UIApplication.getTopMostViewController()?.navigationController?.ifExitsOnStack(vc: LoginVC.self) {
                UIApplication.getTopMostViewController()?.navigationController?.popToViewController(loginVC, animated: true)

            }else {
                let myCartVC = LoginVC(nibName: "LoginVC", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(myCartVC, animated: true)
            }
         
            
            
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL".localized(), style: .default) { (_) in
            self.hide()
            
        }
        self.showAlertWith(message: "Are you sure you want to logout?".localized(), type: .custom(actions: [cancelAction,alertOkAction]))
        
        
    }
    
    
    
}

extension SidePanelViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag == true {
            self.view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
            delegate?.didDisplayMenu(status: true)
        }
    }
}
