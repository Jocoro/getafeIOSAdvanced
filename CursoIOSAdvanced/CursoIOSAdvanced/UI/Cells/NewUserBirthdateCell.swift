//
//  NewUserBirthdateCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class NewUserBirthdateCell: UITableViewCell {
    @IBOutlet var birthdate : UIDatePicker!
    static let cellHeight: CGFloat = 180
    static let cellIdentifier = String(describing: NewUserBirthdateCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        birthdate.datePickerMode = .date
        birthdate.maximumDate = Date()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
