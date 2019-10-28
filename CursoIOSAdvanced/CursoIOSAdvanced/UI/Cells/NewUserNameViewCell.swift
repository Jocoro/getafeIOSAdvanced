//
//  NewUserNameViewCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import Kingfisher

class NewUserNameViewCell: UITableViewCell {
    
     @IBOutlet weak var firstNameLabel : UILabel!
    @IBOutlet weak var lastNameLabel : UILabel!
      @IBOutlet weak var firstName : UITextField!
      @IBOutlet weak var lastName : UITextField!
    @IBOutlet weak var imageInCell: UIImageView!
    
    
    static let cellHeight: CGFloat = 88
    static let cellIdentifier = String(describing: NewUserNameViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      let url = URL(string: "https://randomuser.me/api/portraits/women/49.jpg")
        imageInCell.kf.setImage(with: url)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
