//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Deepankar D on 06/04/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class LoginViewController: UIViewController {

    let db = Firestore.firestore()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationItem.hidesBackButton = true
            emailTextField.layer.cornerRadius = 12
            passwordTextField.layer.cornerRadius = 12
            
            // Do any additional setup after loading the view.
        }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    print("Login Successfull!!!")
                    self.createUsersList()
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
            
        }
    }
    func createUsersList() {
          if let uid = Auth.auth().currentUser?.uid, let email = Auth.auth().currentUser?.email{
//          
//            db.collection('users').doc(user_id).set({foo:'bar'}, {merge: true})
            db.collection(K.FStore.usersCollectionName).addDocument(data: [K.FStore.senderField : email  , K.FStore.uId : uid]).setData([K.FStore.senderField : email  , K.FStore.uId : uid], merge: false) { (error) in
                  if let e = error{
                                    print("Error while creating the users Node \(e.localizedDescription)")
                                }
                                else{
                                    print("Users Node Created Successfully!!!")
                                    
                                }
            }
//            db.collection(K.FStore.usersCollectionName).addDocument(data: [K.FStore.senderField : email  , K.FStore.uId : uid]) { (error) in
//                  if let e = error{
//                      print("Error while creating the users Node \(e.localizedDescription)")
//                  }
//                  else{
//                      print("Users Node Created Successfully!!!")
//                      
//                  }
//            //    self.num += 1
//              }
              
          }
          
      }
        
}

