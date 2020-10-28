//
//  RegisterVC.swift
//  FirebaseAuthTest
//
//  Created by Gautham Sritharan on 6/25/20.
//  Copyright © 2020 Hashan Kannangara. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        //ref = Database.database().reference()
    }
    
    @IBAction func didTapSignUpBtn(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return  }
        guard let password = passwordTextField.text else { return }
        
        /*Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            
            if error == nil {
                print("you have signed up")
                self.AlertProvider()
            }
        }*/
        //let ref = Database.database().reference()
        
        ref.childByAutoId().setValue(["email": email, "password": password]) /*{
            result, error in
            
            if error == nil {
                print("user created!")
            }
        }*/
        
    }
    
    @IBAction func didTapUpdateBtn(_ sender: Any) {
        guard let email = emailTextField.text else { return  }
        guard let password = passwordTextField.text else { return }
        
        //ref.child("-MAeY-uKLkBw-_ErRCqy").setValue(["email": email, "password": password])
        ref.child("-MAeY-uKLkBw-_ErRCqy").updateChildValues(["email": email, "password": password])
    }
    
    
    func AlertProvider() {
        let alert = UIAlertController(title: "Signed Up", message: "You have successfully signed up!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
    }

}
