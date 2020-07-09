//
//  ViewController.swift
//  ChatApp
//
//  Created by Deepankar D on 05/04/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         welcomeLabel.text = K.appName
       
      //  welcomeLabel.charInterval = 0.1
//        Timer.scheduledTimer(withTimeInterval: 0.1 , repeats: false) { (timer) in
//            welcomeLabel.charInterval = 0.1
//        }
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }


}

