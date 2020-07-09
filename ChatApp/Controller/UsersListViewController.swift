//
//  UsersListViewController.swift
//  ChatApp
//
//  Created by Deepankar D on 12/04/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class UsersListViewController : UIViewController{
    let db = Firestore.firestore()
    var users : [Users] = []
    // var message : [Message] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        navigationItem.title = "List of Users"
        navigationItem.hidesBackButton = true
        tableView.delegate = self
        tableView.dataSource = self
        loadUsersList()
    }
    
    func loadUsersList() {
        users = []
        
        db.collection(K.FStore.usersCollectionName).addSnapshotListener { (querySnapshot, error) in
            
            if let e = error{
                print("Error while retreiving users List\(e.localizedDescription)")
            }else
            {
                self.users = []
                if let snapshotDocuments = querySnapshot?.documents{
                    
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let email = data[K.FStore.senderField] as? String, let uId = data[K.FStore.uId] as? String {
                            let userid = Auth.auth().currentUser?.uid
                            if (uId != userid){
                                
                                let user = Users(email: email, uId: uId)
                             
                                self.users.append(user)
                            }
                            
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
    
    
    
}

extension UsersListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user.email
        return cell
    }
    
    
}
extension UsersListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.usersListSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.usersListSegue {
            if let destinationUid = segue.destination as? ChatViewController {
                if let indexPath = tableView.indexPathForSelectedRow{
                    destinationUid.selectedUid = users[indexPath.row].uId
                    //  destinationUid.messages = users[indexPath.row].message
                }
            }
            
            
        }
    }
    
}
