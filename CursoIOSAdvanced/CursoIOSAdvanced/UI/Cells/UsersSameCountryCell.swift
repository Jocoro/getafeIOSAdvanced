//
//  UsersSameCountryCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 18/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class UsersSameCountryCell: UITableViewCell {
    @IBOutlet weak var viewInCell: UIView!
   // @IBOutlet weak var viewWithCollection: UIView!
    @IBOutlet  var titleOfCollection: UILabel!
    @IBOutlet var collectionView : UICollectionView!
    
    static let cellIdentifier = String(describing: UsersSameCountryCell.self)
    static let cellHeight: CGFloat = 480
    var users : [User] = []
    var nextUser : User?
    
    override func prepareForReuse(){
        users = []
        titleOfCollection.text = nil
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configure(collectionView: collectionView)
        viewInCell.configureShadows()
        viewInCell.layer.cornerRadius = 8.0
        //viewWithCollection.configureShadows()
        //viewWithCollection.layer.cornerRadius = 8.0
    }
    
}
extension UsersSameCountryCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Configure collection view
    func configure(collectionView: UICollectionView){
        collectionView.register(UINib(nibName: PersonCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: PersonCollectionViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
    }
    func configureCell(users: [User] = [], country: String? = nil){
        self.users = users
        configure(collectionView: collectionView)
        guard let countryUser = country else{
            return
        }
        titleOfCollection.text = "Users from \(countryUser): \(users.count)\n Select one and click here"
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.cellIdentifier, for: indexPath) as? PersonCollectionViewCell else {
            return UICollectionViewCell()
        }
        if(indexPath.row < users.count){
            let user = users[indexPath.row]
            cell.configureCell(image: user.avatar, title: user.name)
            designCell(cell: cell)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 32.0) / 3.5
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        nextUser = users[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = UIColor.blue.cgColor
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        designCell(cell: cell)
        
    }
    func designCell(cell: UICollectionViewCell){
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 8.0
        cell.layer.borderWidth = 5.0
    }
}
