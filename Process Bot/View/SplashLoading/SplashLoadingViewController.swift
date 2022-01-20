//
//  SplashLoadingViewController.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 21/07/21.
//

import UIKit

class SplashLoadingViewController: UIViewController {
    
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var SplashProgressVw: UIProgressView!
    
    let progress = Progress(totalUnitCount: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        load()

        // Do any additional setup after loading the view.
    }
    func load(){
        SplashProgressVw.progress = 0.0
           progress.completedUnitCount = 0

           // 2
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { (timer) in
               guard self.progress.isFinished == false else {
                   timer.invalidate()
                self.callLoginVC()
                   return
               }
               
               // 3
               self.progress.completedUnitCount += 1
               self.SplashProgressVw.setProgress(Float(self.progress.fractionCompleted), animated: true)

               self.lblProgress.text = "\(Int(self.progress.fractionCompleted * 100)) %"
           }
    }
    
    func callLoginVC(){
        let serviceVC = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.pushViewController(serviceVC, animated: true)
    }


}
