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
    @IBOutlet weak var nationality: UILabel!
    
    override func prepareForReuse() {
           country.text = nil
        nationality.text = nil
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(country: String? = nil, nationality: String? = nil){
       
          self.country.text = country
        self.nationality.text = nationality
        if let nationalityCell = nationality{
            self.nationality.text = "\(nationalityCell) \(flag(country: nationalityCell))"
               }
         }
  func flag(country:String) -> String {
      let base : UInt32 = 127397
      var s = ""
      for v in country.unicodeScalars {
          s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
      }
      return String(s)
  }
    
}
