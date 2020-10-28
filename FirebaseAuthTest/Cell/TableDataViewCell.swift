//
//  TableDataViewCell.swift
//  FirebaseAuthTest
//
//  Created by Gautham Sritharan on 6/25/20.
//  Copyright © 2020 Hashan Kannangara. All rights reserved.
//

import UIKit

class TableDataViewCell: UITableViewCell {
    
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var lastnameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    var userID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with model: User) {
        
        userID = model.id
        
        firstnameLbl.text = model.firstName ?? "-"
        lastnameLbl.text = model.lastName ?? "-"
        phoneLbl.text = model.phone ?? "-"
        emailLbl.text = model.email ?? "-"
    }

}
