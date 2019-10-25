//
//  NewUserGenderCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class NewUserGenderCell: UITableViewCell {
    
    
   
   
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var chooseGender: UILabel!
    
    static let cellHeight: CGFloat = 88
    let genderTypes = ["Female", "Male"]
    var gender: String?
       static let cellIdentifier = String(describing: NewUserGenderCell.self)
  override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
          configure(collectionView: collectionView)
            chooseGender.text = "Gender:"
        }

       func configure(collectionView: UICollectionView){
            collectionView.register(UINib(nibName: GenderOptionCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: GenderOptionCell.cellIdentifier)
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
        extension NewUserGenderCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return genderTypes.count
               }
               
               func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderOptionCell.cellIdentifier, for: indexPath) as? GenderOptionCell else{
                   return UICollectionViewCell()
               }
                let genderCode = genderTypes[indexPath.row]
                    cell.configureCell(gender: genderSymbol(gender: genderCode))
                    designCell(cell: cell)
                    return cell
               
              
               }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: 40, height: 40)
            }
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                  
                 
                  let cell = collectionView.cellForItem(at: indexPath)
                  
                  cell?.layer.borderColor = UIColor.blue.cgColor
                let genderCode = genderTypes[indexPath.row]
              gender = genderCode
                chooseGender.text = "Gender: \(genderCode)"
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
            func genderSymbol(gender:String) -> String {
                switch gender{
                case "Female":
                return "♀"
                case "Male":
                    return "♂"
                default:
                    return ""
                }
        }
}
