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
    
    @IBAction func onListTypePressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            tableView.isHidden = false
            collectionView.isHidden = true
            tableView.reloadData()
        default:
            tableView.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
    private var users : [User] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure(tableView: tableView)
        configure(collectionView: collectionView)
        loadUsers()
    }
    
    private func loadUsers(){
        DataManager.shared.usersForceUpdate { [weak self] result in
            switch result{
            case .success(let data):
                guard let usersData = data as? [User] else {
                    return
                }
                self?.users = usersData
                switch self?.segmentOptions.selectedSegmentIndex{
                case 0:
                    self?.tableView.reloadData()
                default:
                    self?.collectionView.reloadData()
                    
                }
            case .failure(let msg):
                print(msg)
            }
        }
    }
    
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    /// Configure table view
    func configure(tableView: UITableView){
        
        tableView.register(UINib(nibName: PersonTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PersonTableViewCell.cellIdentifier)
        tableView.contentInset = UIEdgeInsets(top: segmentOptions.frame.origin.y + segmentOptions.frame.height,left: 0,bottom: 0,right: 0)
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
        collectionView.register(UINib(nibName: PersonCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: PersonCollectionViewCell.cellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: segmentOptions.frame.origin.y + segmentOptions.frame.height,left: 0,bottom: 0,right: 0)
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
     
}
extension UsersViewController{
    //Opciones por defecto
    func loadPreferences(){
        let segmentedPreference = DataManager.shared.getDefaultOptions()
        switch segmentedPreference {
        case 0:
            segmentOptions.
        default:
            
        }
    }
    func savePreferences(){
        
    }
}
