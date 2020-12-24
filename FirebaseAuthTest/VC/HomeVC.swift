//
//  HomeVC.swift
//  FirebaseAuthTest
//
//  Created by Ranula Ranatung on 6/25/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseDatabase
import FirebaseAuth

class HomeVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate {
    
    let bag = DisposeBag()
    
    var userList = BehaviorRelay<[User]>(value: [])
    
    //var firstName = BehaviorRelay<String>(value: "")
    //var lastName = BehaviorRelay<String>(value: "")
    //var phone = BehaviorRelay<String>(value: "")
    //var email = BehaviorRelay<String>(value: "")

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDataBindObservers()
        self.fetchFirebaseData()
        
        tableView.rx.setDelegate(self).disposed(by: bag)

    }
    
    @IBAction func didTapLogOutBtn(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "firebase-user-key")
        try! Auth.auth().signOut()
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "login") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapAddBtn(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "addData") as! AddDataVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchFirebaseData() {
        
           let ref = Database.database().reference().child("users")
           
           ref.observe(.value, with: { (snapshot) in
               guard let value = snapshot.value as? [String: Any] else {
                   return
               }
               var users = [User]()
               for (_, value) in value {
                   guard let userdict = value as? [String: Any],
                       let id = userdict["id"] as? String,
                       let firstname = userdict["firstname"] as? String,
                       let email = userdict["email"] as? String,
                       let phone = userdict["phone"] as? String,
                       let createdAt = userdict["created_at"] as? String,
                       let updatedAt = userdict["updated_at"] as? String,
                       let lastname = userdict["lastname"] as? String else {
                           continue
                   }
                users.append(User(_id: id, uuid: nil, firstName: firstname, lastName: lastname, fullName: nil, phone: phone, email: email, created_at: createdAt, updated_at: updatedAt))
               }
               
                self.userList.accept(users)
               
               // if you have some completion return retrieved array of stations
            
           })
    }
    
    func deleteFromDatabase(at indexPath: IndexPath) {
        
        let ref = Database.database().reference(withPath: "users")
 
        guard let userID = self.userList.value[indexPath.row].id else { return }
        
        ref.child(userID).removeValue()
        
    }
    
    func goToUpdateVC(at indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "updateData") as! UpdateVC
        
        let _user = self.userList.value[indexPath.row]
        vc.user.accept(_user)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addDataBindObservers() {
        
        userList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: TableDataViewCell.self)) { row, model, cell in
                
                cell.configureCell(with: model)
        }
        .disposed(by: bag)
        
        tableView.rx.itemDeleted
            .subscribe(onNext: { self.deleteFromDatabase(at: $0) })
        .disposed(by: bag)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let updateAction = UIContextualAction(style: .destructive, title: "Update") { (action, view, handler) in
            self.goToUpdateVC(at: indexPath)
        }
        
        updateAction.backgroundColor = .blue
        let configuration = UISwipeActionsConfiguration(actions: [updateAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}
