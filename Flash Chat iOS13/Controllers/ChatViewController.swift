//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = [
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = Constants.appName
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

        loadMessages()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
      if  let messageBoady = messageTextfield.text,
          let messageSemder = Auth.auth().currentUser?.email {
          db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSemder,Constants.FStore.bodyField: messageBoady]) { (error) in
              if let e = error {
                  print ("error")
              }else {
                  print("successfully saved date")
                  self.messageTextfield.text = ""
              }
          }
      }
        
        
    }
    
    
    func loadMessages(){
        messages = [ ]
       
        db.collection(Constants.FStore.collectionName).getDocuments { QuerySnapshot, error in
            if let e = error{
                print("Error got while loading data ")
                
            }else {
                if let sanpshotDocuments = QuerySnapshot?.documents{
                    for doc in sanpshotDocuments{
                        let data = doc.data()
                        if let sender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String{
                        let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                        }
                        
                    }
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                   
                }
            }
        }

    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        as! MessageCell
        cell.label?.text = messages[indexPath.row].body
        
        
        return cell
    }
    
    
}


