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
    //let countries = ["Australia", "Brazil", "Canada", "Denmark", "Finland", "France", "Germany", "Iran", "Ireland", "Netherlands", "New Zealand", "Norway", "Spain", "Switzerland", "Turkey", "United Kingdom", "United States"]
    let countriesCodes = Locale.isoRegionCodes
    var countries : [String] {
        var countries : [String] = []
    
    for code in  countriesCodes {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = NSLocale(localeIdentifier: "en").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        countries.append(name)
    }
        return countries
    }
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
