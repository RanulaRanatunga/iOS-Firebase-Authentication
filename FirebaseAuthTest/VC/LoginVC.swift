//
//  LoginVC.swift
//  FirebaseAuthTest
//
//  Created by Ranula Ranatunga on 6/25/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLoginBtn(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return  }
        guard let password = passwordTextField.text else { return }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { 
            result, error in
            
            if error == nil {
                //print("you have signed in")
                //Firebase.auth().Auth.Persistence.SESSION
                
                let userId = Auth.auth().currentUser?.uid
                UserDefaults.standard.set(userId, forKey: "firebase-user-key")
                
                let sb = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "home") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                print("Error sign in")
            }
        })
        
    }
}
