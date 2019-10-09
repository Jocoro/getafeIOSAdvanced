//
//  SplashViewController.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    private var cellSpacing: CGFloat = 16
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var segmentOptions : UISegmentedControl!
    
    private var users : [User] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadUsers()
    }
    
    private func loadUsers(){
        DataManager.shared.users { [weak self] result in
            switch result{
            case .success(let data):
                guard let usersData = data as? [User] else {
                    return
                }
                self?.users = usersData
            case .failure(let msg):
                print(msg)
            }
        }
    }
    
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    /// Configure table view
    func configure(tableView: UITableView){
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.cellIdentifier, for: indexPath) as? PersonTableViewCell else {
            return UITableViewCell()
        }
        if(indexPath.row < users.count){
            let user = users[indexPath.row]
            cell.configureCell(image: user.avatar, name: user.name, email: user.email)
        }
        return cell
    }
}
extension UsersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Configure collection view
    func configure(collectionView: UICollectionView){
        collectionView.dataSource = self
        collectionView.delegate = self
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
