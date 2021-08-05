//
//  Routing.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 14/07/21.
//

import Foundation
import UIKit


final class Routing {
    
    class func decideInitialViewController(window:UIWindow?) {
    

    }
    
    class func initiateLoginScreen(window:UIWindow?) {
        let startVC = LoginVC(nibName: "LoginVC", bundle: nil)
        let navigationController = UINavigationController(rootViewController: startVC)
        navigationController.navigationBar.isHidden = true
        navigationController.setNeedsStatusBarAppearanceUpdate()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

