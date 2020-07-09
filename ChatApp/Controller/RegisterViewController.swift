//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Deepankar D on 06/04/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            emailTextField.layer.cornerRadius = 12
            passwordTextField.layer.cornerRadius = 12
            
            // Do any additional setup after loading the view.
        }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                // [START_EXCLUDE]
                
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Registered Successfully!!")
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
            
        }
        
        
    }
    
}
