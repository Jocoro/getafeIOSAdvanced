//
//  NewUserNationalityCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class NewUserNationalityCell: UITableViewCell {

   @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var choseNationality: UILabel!
        static let cellHeight: CGFloat = 88
    let nationalityTypes = Locale.isoRegionCodes
           
        var nationality: String?
           static let cellIdentifier = String(describing: NewUserNationalityCell.self)
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
          configure(collectionView: collectionView)
            choseNationality.text = "Nationality:"
        }

       func configure(collectionView: UICollectionView){
            collectionView.register(UINib(nibName: GenderOptionCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: GenderOptionCell.cellIdentifier)
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
        extension NewUserNationalityCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return nationalityTypes.count
               }
               
               func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderOptionCell.cellIdentifier, for: indexPath) as? GenderOptionCell else{
                   return UICollectionViewCell()
               }
                let nationalityCode = nationalityTypes[indexPath.row]
                    cell.configureCell(gender: flag(country: nationalityCode))
                    designCell(cell: cell)
                    return cell
               
              
               }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: 40, height: 40)
            }
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                  
                 
                  let cell = collectionView.cellForItem(at: indexPath)
                  
                  cell?.layer.borderColor = UIColor.blue.cgColor
                let nationalityCode = nationalityTypes[indexPath.row]
              nationality = nationalityCode
                choseNationality.text = "Nationality: \(nationalityCode)"
            }
              func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
                  guard let cell = collectionView.cellForItem(at: indexPath) else {
                      return
                  }
                  designCell(cell: cell)
                  
              }
              func designCell(cell: UICollectionViewCell){
                  cell.layer.borderColor = UIColor.gray.cgColor
                  cell.layer.cornerRadius = 8.0
                  cell.layer.borderWidth = 5.0
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
        

