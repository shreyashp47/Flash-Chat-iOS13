//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
       if let password = passwordTextfield.text, let  email = emailTextfield.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
             
            
                if let e = error {
                    print(e.localizedDescription)
                    //Make a toast to show error
                } else {
                    //Navigate to chatViewController
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
                
                
            }
        }
    }
    
}
