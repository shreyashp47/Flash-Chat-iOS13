//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages : [Message] = [
        Message(sender: "shreyash@g.com", body: "hii"),
        Message(sender: "your@s.com",body: "hello hello hello hello hello hello hello hello hello "),
        Message(sender: "shreyash@g.com", body: "wasuo")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = Constants.appName
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
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


