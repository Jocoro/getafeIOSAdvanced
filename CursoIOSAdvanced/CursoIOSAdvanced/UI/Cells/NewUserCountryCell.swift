//
//  NewUserCountryCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class NewUserCountryCell: UITableViewCell {
  
    

   @IBOutlet weak var countryLabel : UILabel!
        @IBOutlet weak var country : UIPickerView!
    
    var selectedCountry = "Australia"
        let countries = ["Australia", "Brazil", "Canada", "Denmark", "Finland", "France", "Germany", "Iran", "Ireland", "Netherlands", "New Zealand", "Norway", "Spain", "Switzerland", "Turkey", "United Kingdom", "United States"]
          static let cellHeight: CGFloat = 100
         static let cellIdentifier = String(describing: NewUserCountryCell.self)
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            country.delegate = self
            country.dataSource = self
            
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
    }
extension NewUserCountryCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
      }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       selectedCountry = countries[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
}
