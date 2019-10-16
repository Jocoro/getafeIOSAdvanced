//
//  CountryCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
     static let cellIdentifier = String(describing: CountryCell.self)
    
     @IBOutlet weak var country: UILabel!
    
    override func prepareForReuse() {
           country.text = nil
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(country: String? = nil){
         
          self.country.text = country
         }
  
    
}
