//
//  PersonCollectionViewCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
class PersonCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: PersonCollectionViewCell.self)
    
    // MARK: -Outlets-
    @IBOutlet weak var viewInCell: UIView!
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shadowView: UIView!
    // MARK: -LyfeCycle -
    override func prepareForReuse() {
        imageInCell.image = nil
        name.text = nil
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewInCell.configureShadows()
        viewInCell.layer.cornerRadius = 8.0
        shadowView.layer.cornerRadius = 8.0
        shadowView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    func configureCell(image: String? = nil, title: String? = nil){
        imageInCell.image = UIImage(named: image ?? "")
        name.text = title
        
        
    }
    
}
