//
//  AddDataVC.swift
//  FirebaseAuthTest
//
//  Created by Gautham Sritharan on 6/25/20.
//  Copyright © 2020 Hashan Kannangara. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import FirebaseDatabase
import Firebase

class AddDataVC: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var didTapAddBtn: UIButton!
    
    var firstName = BehaviorRelay<String>(value: "")
    var lastName = BehaviorRelay<String>(value: "")
    var phone = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    
    let ref = Database.database().reference()
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObservers()
    }
    
    func addObservers() {
        
        didTapAddBtn.rx.tap
            .subscribe() {[weak self] event in
                self?.addNewUserToList()
        }
        .disposed(by: bag)
        
        firstnameTextField.rx.text
            .orEmpty
            .bind(to: firstName)
            .disposed(by: bag)
        
        lastnameTextField.rx.text
            .orEmpty
            .bind(to: lastName)
            .disposed(by: bag)
        
        phoneTextField.rx.text
            .orEmpty
            .bind(to: phone)
            .disposed(by: bag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: email)
            .disposed(by: bag)
    }
    
    func addNewUserToList() {
        
        let _user = User(_id: nil, uuid: nil, firstName: self.firstName.value, lastName: self.lastName.value, fullName: nil, phone: self.phone.value, email: self.email.value, created_at: "", updated_at: "")
        let ref = Database.database().reference(withPath: "users").childByAutoId()
        let newUserId = ref.key ?? NSUUID().uuidString
        
        let createdAt = Firebase.ServerValue.timestamp()
        let updatedAt = Firebase.ServerValue.timestamp()
        
        let userInfoDictionary = ["id" :newUserId,
                                  "firstname" : self.firstName.value,
                                  "lastname" : self.lastName.value,
                                  "phone" : self.phone.value,
                                  "email" : self.email.value,
                                  "created_at" : createdAt,
                                  "updated_at" : updatedAt,
            ] as [String : Any]
        
        
        ref.setValue(userInfoDictionary) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var currentUsers: [User] = HomeVC().userList.value
                currentUsers.append(_user)
                HomeVC().userList.accept(currentUsers)
            }
        }
    }
}
