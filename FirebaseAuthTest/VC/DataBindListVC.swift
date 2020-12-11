//
//  DataBindListVC.swift
//  Training-iOS-DataSources
//
//  Created by Ranula Ranatunga  on 9/6/20.
//  Copyright © 2020 Ranula Ranatunga . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseDatabase

class DataBindListVC: UIViewController, UIScrollViewDelegate {
    
    let bag = DisposeBag()
    
    var userList = BehaviorRelay<[User]>(value: [])
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    
    //let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        //addObservers()
        //addDataBindObservers()
    }
    
    func setupUI() {
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        //tableView.register(UINib(nibName: "UserTVCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    /*func addObservers() {
          ref.observe(.childAdded, with: { (snapshot) -> Void in
          self.userList.append(snapshot)
          self.tableView.insertRows(at: [IndexPath(row: self.userList.count-1, section: self.kSectionComments)], with: UITableView.RowAnimation.automatic)
        })
    }*/
    
    func addDataBindObservers() {
        
        userList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: TableDataViewCell.self)) { row, model, cell in
                
               // cell.configureCell()
        }
        .disposed(by: bag)
    }

}
