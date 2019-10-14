//
//  PersonViewCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import Kingfisher
class PersonTableViewCell: UITableViewCell {
    
    static let cellIdentifier = String(describing: PersonTableViewCell.self)
    
    @IBOutlet weak var viewInCell: UIView!
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var birthdate: UILabel!
    
    
    override func prepareForReuse() {
        imageInCell.image = nil
        name.text = nil
        email.text = nil
        age.text = nil
        birthdate.text = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewInCell.configureShadows()
        viewInCell.layer.cornerRadius = 8.0
        
    }
    func configureCell(image: String? = nil, name: String? = nil, email: String? = nil, age: String? = nil, birthdate: Date? = nil){
        let url = URL(string: image ?? "")
        imageInCell.kf.setImage(with: url)
        self.name.text = name
        self.email.text = email
        self.age.text = age
        //Para transformar la fecha en String
        if let birthdate = birthdate{
                   let formatter = DateFormatter()
                   formatter.dateFormat = "dd' del 'MM' de 'yyyy"
        self.birthdate.text = formatter.string(from: birthdate)
        }
        
    }
    class func createCell() -> PersonTableViewCell? {
           let nib = UINib(nibName: "CustomCell", bundle: nil)
           let cell = nib.instantiate(withOwner: self, options: nil).last as? PersonTableViewCell
           return cell
       }
}
