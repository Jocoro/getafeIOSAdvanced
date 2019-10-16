//
//  PersonalDataCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class PersonalDataCell: UITableViewCell {
    
     static let cellIdentifier = String(describing: PersonalDataCell.self)
    static var cellType = UserDetailCellType.personalData
    
       @IBOutlet weak var imageInCell: UIImageView!
       @IBOutlet weak var name: UILabel!
       @IBOutlet weak var age: UILabel!
        @IBOutlet weak var birthdate: UILabel!
  
     override func prepareForReuse() {
            imageInCell.image = nil
            name.text = nil
            age.text = nil
            birthdate.text = nil
        }
       

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(image: String? = nil, name: String? = nil, age: String? = nil, birthdate: Date? = nil){
        let url = URL(string: image ?? "")
        imageInCell.kf.setImage(with: url)
        self.name.text = name
        if let age = age {
            self.age.text = age + " años"}
        //Para transformar la fecha en String
        if let birthdate = birthdate{
                   let formatter = DateFormatter()
                   formatter.dateFormat = "dd' del 'MM' de 'yyyy"
        self.birthdate.text = "Fecha de nacimiento: " + formatter.string(from: birthdate)
        }
        
    }
    
    
}
