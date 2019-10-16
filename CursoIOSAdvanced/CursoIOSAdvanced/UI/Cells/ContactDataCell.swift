//
//  ContactDataCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class ContactDataCell: UITableViewCell {
    
     static let cellIdentifier = String(describing: ContactDataCell.self)
    
           @IBOutlet weak var email: UILabel!
    
    override func prepareForReuse() {
        email.text = nil
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(email: String? = nil){
       
        self.email.text = email
       }
    
    
}
