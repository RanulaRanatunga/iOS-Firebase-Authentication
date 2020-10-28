//
//  UpdateVC.swift
//  FirebaseAuthTest
//
//  Created by Gautham Sritharan on 6/29/20.
//  Copyright © 2020 Hashan Kannangara. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import FirebaseDatabase



class UpdateVC: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var didTapUpdateBtn: UIButton!
    
    var firstName = BehaviorRelay<String>(value: "")
    var lastName = BehaviorRelay<String>(value: "")
    var phone = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    
    var user = BehaviorRelay<User?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addObservers()
        self.setInputValues()
    }
    
    func addObservers() {
        
        didTapUpdateBtn.rx.tap
            .subscribe() {[weak self] event in
                self?.updateUser(id: self?.user.value?.id ?? "")
        }
        .disposed(by: bag)
        
        firstnameTF.rx.text
            .orEmpty
            .bind(to: firstName)
            .disposed(by: bag)
        
        lastnameTF.rx.text
            .orEmpty
            .bind(to: lastName)
            .disposed(by: bag)
        
        phoneTF.rx.text
            .orEmpty
            .bind(to: phone)
            .disposed(by: bag)
        
        emailTF.rx.text
            .orEmpty
            .bind(to: email)
            .disposed(by: bag)
    }
    
    func updateUser(id: String) {
        
        let ref = Database.database().reference(withPath: "users")
        
        let newUserId = id
        let userInfoDictionary = ["firstname" : self.firstName.value,
                                  "lastname" : self.lastName.value,
                                  "phone" : self.phone.value,
                                  "email" : self.email.value]
        
        ref.child(newUserId).updateChildValues(userInfoDictionary) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let currentUsers: [User] = HomeVC().userList.value
                HomeVC().userList.accept(currentUsers)
            }
        }
    }
    
    func setInputValues() {
        
        firstName.accept(self.user.value?.firstName ?? "")
        lastName.accept(self.user.value?.lastName ?? "")
        email.accept(self.user.value?.email ?? "")
        phone.accept(self.user.value?.phone ?? "")
        
        firstnameTF.text = firstName.value
        lastnameTF.text = lastName.value
        emailTF.text = email.value
        phoneTF.text = phone.value
    }
}
