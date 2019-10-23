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
    @IBOutlet var totalUsers : UILabel!
    @IBOutlet var sortByCountry: UIButton!
    
    @IBAction func onListTypePressed(_ sender: UISegmentedControl) {
        saveSegmentPreference(option: sender.selectedSegmentIndex)
        showUsers()
    }
    @IBAction func onButtonPressed(_ sender: UIButton){
        changeSortingPreference()
        loadSortingLabel()
        loadUsers(forceUpdate: false)
    }
    
    var users : [User] = []
 
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadSegmentPreference()
        loadSortingLabel()
        configureView(viewName: totalUsers)
        configureView(viewName: sortByCountry)
        configure(tableView: tableView)
        configure(collectionView: collectionView)
        
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        loadUsers(forceUpdate: false)
    }
    private func updateTotalUsers(){
        let totalFemales = users.filter {$0.gender == "female"}.count
        let totalMales = users.filter{$0.gender == "male"}.count
        totalUsers.text = "M: \(totalMales) W: \(totalFemales)"
    }
    private func configureView(viewName: UIView){
        viewName.layer.cornerRadius = 8.0
        viewName.layer.borderWidth = 1
        viewName.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        viewName.layer.backgroundColor = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 0.5)
    }
    private func showUsers(){
        switch segmentOptions.selectedSegmentIndex{
        case 0:
            tableView.reloadData()
            tableView.isHidden = false
            collectionView.isHidden = true
        default:
            collectionView.reloadData()
            tableView.isHidden = true
            collectionView.isHidden = false
            
        }
        
    }
    func loadUsers(forceUpdate: Bool){
        if forceUpdate{
            DataManager.shared.usersForceUpdate { [weak self] result in
                self?.parseUsers(result: result)
            }
        } else {
            DataManager.shared.users { [weak self] result in
                self?.parseUsers(result: result)
            }
        }
    }
    private func parseUsers(result: ServiceResult){
        switch result{
        case .success(let data):
            guard let usersData = data as? [User] else {
                return
            }
            self.users = usersData
            self.showUsers()
        case .failure(let msg):
            print(msg)
        }
          updateTotalUsers()
    }
   
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    /// Configure table view
    func configure(tableView: UITableView){
        
        tableView.register(UINib(nibName: PersonTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PersonTableViewCell.cellIdentifier)
        tableView.contentInset = UIEdgeInsets(top: segmentOptions.frame.height + 12,left: 0,bottom: 0,right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        configureRefreshTable()
        
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
            
            
            cell.configureCell(image: user.avatar, name: user.name, email: user.email, age: "Age: \(String(user.age))",
                birthdate: user.birthdate)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              tableView.deselectRow(at: indexPath, animated: true)
              
              self.performSegue(withIdentifier: "DetailSegue", sender: indexPath)
             
          }
}
extension UsersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Configure collection view
    func configure(collectionView: UICollectionView){
        collectionView.register(UINib(nibName: PersonCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: PersonCollectionViewCell.cellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: segmentOptions.frame.height + 20,left: 0,bottom: 0,right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        configureRefreshCollection()
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
           self.performSegue(withIdentifier: "DetailSegue", sender: indexPath)
       }
    
}
extension UsersViewController{
    //Opciones por defecto
    private func loadSegmentPreference(){
        segmentOptions.selectedSegmentIndex = DataManager.shared.defaultSegment
        
    }
    private func loadSortingLabel(){
        switch DataManager.shared.defaultSorting{
        case true:
            sortByCountry.setTitle("Sort by age", for: .normal)
        case false:
            sortByCountry.setTitle("Sort by country", for: .normal)
        }
    }
    private func saveSegmentPreference(option: Int){
        DataManager.shared.saveDefaultSegment(option: option)
    }
    private func changeSortingPreference(){
        DataManager.shared.changeDefaultSorting()
    }
}
// refresh collection y tableView
extension UsersViewController {
    func configureRefreshCollection () {
        // Add the refresh control to your UIScrollView object.
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshCollection),
                                                 for: .valueChanged)
    }
    
    @objc func handleRefreshCollection() {
        // Update your content…
        loadUsers(forceUpdate: true)
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    func configureRefreshTable () {
        // Add the refresh control to your UIScrollView object.
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshTable),
                                            for: .valueChanged)
    }
    
    @objc func handleRefreshTable() {
        // Update your content…
        loadUsers(forceUpdate: true)
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}
extension UsersViewController{
  
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if  segue.identifier == "DetailSegue",
                let destination = segue.destination as? UserDetail,
                let indexPath = sender as? IndexPath
                 
             {
                destination.user = users[indexPath.row]
                let country = users[indexPath.row].country
                destination.usersSameCountry = users.filter{$0.country == country && $0.id != users[indexPath.row].id}
             }
         }
    
   
}

