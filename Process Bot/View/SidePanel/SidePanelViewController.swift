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
    var arrayMenuDispaly = [["Digital worked","robot_icon"],["Process","process_icon"],["Cognitive Bot","cognative_icon"],["Administrative","administrative_icon"],["Machine Host","machine_hos_icon"],["Dashboard","dashboard_icon"],["Logout","logout_icon"]]
    
   override func viewDidLoad() {
        super.viewDidLoad()
    tableSidePanelList.delegate = self
    tableSidePanelList.dataSource = self
    tableSidePanelList.register(SidePanelTableViewCell.self)
    viewShadow.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)

        // Do any additional setup after loading the view.
    }
    
    
    func show(on parent:UIViewController) {
        
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
       
    }
    
    
    func hide(handler: ((Bool) -> Void)? = nil) {
        delegate?.didDisplayMenu(status: false)
        self.view.backgroundColor = .clear
        
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
    
   

}

extension SidePanelViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuDispaly.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: SidePanelTableViewCell.self), for: indexPath) as! SidePanelTableViewCell

        cell.selectionStyle = .gray
        cell.lblMenu.text = arrayMenuDispaly[indexPath.row][0]
        cell.imageMenu.image = UIImage(named: arrayMenuDispaly[indexPath.row][1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            if let VC = UIApplication.getTopMostViewController()?.navigationController?.ifExitsOnStack(vc: RobotVC.self) {
                UIApplication.getTopMostViewController()?.navigationController?.popToViewController(VC, animated: true)
            }
            else {
                let VC = RobotVC(nibName: "RobotVC", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)

            }
        }else if (indexPath.row == 1){

//            if let VC = UIApplication.getTopMostViewController()?.navigationController?.ifExitsOnStack(vc: RobotDetailsVC.self) {
//                UIApplication.getTopMostViewController()?.navigationController?.popToViewController(VC, animated: true)
//            }
//            else {
//                let VC = RobotDetailsVC(nibName: "RobotDetailsVC", bundle: nil)
//                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)
//            }
        }
        else if (indexPath.row == 2){

           

        } else if (indexPath.row == 3){
            
        }
        else if (indexPath.row == 4){
            
        }
        else if (indexPath.row == 5){
            if let VC = UIApplication.getTopMostViewController()?.navigationController?.ifExitsOnStack(vc: DashboardVC.self) {
                UIApplication.getTopMostViewController()?.navigationController?.popToViewController(VC, animated: true)
            }
            else {
                let VC = DashboardVC(nibName: "DashboardVC", bundle: nil)
                UIApplication.getTopMostViewController()?.navigationController?.pushViewController(VC, animated: true)

     }
        }
        else{


            logout()
        }
        hide()

    }
    
    
    func logout() {
        
       
        
        
        let alertOkAction = UIAlertAction(title: "YES".localized(), style: .default) { (_) in
            
//            let defaults = UserDefaults.standard
//            defaults.synchronize()
//            defaults.removeObject(forKey: "ID")
//            defaults.removeObject(forKey: "EMAIL")
//            defaults.removeObject(forKey: "NAME")
//            if let appDomain = Bundle.main.bundleIdentifier {
//                UserDefaults.standard.removePersistentDomain(forName: appDomain)
//            }
//            // UserDefaults.standard.synchronize()
//            let manager = LoginManager()
//            manager.logOut()
            if let editpassVC = UIApplication.getTopMostViewController()?.navigationController?.ifExitsOnStack(vc: LoginVC.self) {
                UIApplication.getTopMostViewController()?.navigationController?.popToViewController(editpassVC, animated: true)

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
