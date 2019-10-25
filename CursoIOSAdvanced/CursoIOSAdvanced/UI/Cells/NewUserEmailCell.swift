//
//  NewUserEmailCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class NewUserEmailCell: UITableViewCell {

    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var email : UITextField!
    
      static let cellHeight: CGFloat = 44
     static let cellIdentifier = String(describing: NewUserEmailCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
