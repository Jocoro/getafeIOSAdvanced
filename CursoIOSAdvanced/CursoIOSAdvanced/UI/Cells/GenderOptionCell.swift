//
//  GenderOptionCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class GenderOptionCell: UICollectionViewCell {
    @IBOutlet weak var gender: UILabel!
    static let cellIdentifier = String(describing: GenderOptionCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
     gender.text = "nil"
    }
    func configureCell(gender: String? = nil){
        self.gender.text = gender
       }
}
