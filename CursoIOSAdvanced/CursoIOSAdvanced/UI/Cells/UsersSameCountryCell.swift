//
//  UsersSameCountryCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 18/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class UsersSameCountryCell: UITableViewCell {
    
    @IBOutlet  var titleOfCollection: UILabel!
     @IBOutlet var collectionView : UICollectionView!
    
     static let cellIdentifier = String(describing: UsersSameCountryCell.self)
      var users : [User] = []
    
    override func prepareForReuse(){
        users = []
        titleOfCollection.text = nil
        configure(collectionView: collectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        guard let country = country
        titleOfCollection.text = "Others users from \(country)"
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
    }
    return cell
}
}
