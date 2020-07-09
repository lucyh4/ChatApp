//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Deepankar D on 06/04/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit
class ChatViewController: UIViewController {
    var selectedUid = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    let uId = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    func loadMessages(){
        messages = []
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            
            if let e = error{
                print("Error while retrieving the data!!\(e)")
            }else{
                self.messages = []
                if let snapshotDocuments = querySnapshot?.documents{
                    
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String , let toId = data[K.FStore.toId] as? String, let uid = data[K.FStore.uId] as? String{
                            //     let userid = Auth.auth().currentUser?.uid
                            if ((toId == self.selectedUid && uid == self.uId) || (toId == self.uId && uid == self.selectedUid)){
                                let message = Message(sender: sender, body: messageBody, uId: self.uId!, toId: toId)
                              //  print("Messages\(message)")
                             //   print("SelectedId\(self.selectedUid)")
                             //   print("Toid\(toId)")
                                //  if self.selectedUid == message.toId {
                                self.messages.append(message)
                            }
                            
                            
                            
                            //  }
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
//                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            // Add a second document with a generated ID.
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.uId : uId!,
                K.FStore.toId : selectedUid,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error{
                    print("Error while saving the data \(e.localizedDescription)")
                }
                else{
                    
                    print("Data Saved Successfully!!!")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            print("I am hre")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor =  UIColor(named: K.Color.appLightPurple)
            cell.label.textColor = UIColor(named: K.Color.appDarkPurple)
        }
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor =  UIColor(named: K.Color.appDarkPurple)
            cell.label.textColor = UIColor(named: K.Color.appLightPurple)
        }
        return cell
    }
    
    
}
