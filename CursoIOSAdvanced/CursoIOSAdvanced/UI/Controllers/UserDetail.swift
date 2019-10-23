//
//  UserDetail.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class UserDetail: UIViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet var deleteButton : UIButton!
    
    @IBAction func onButtonPressed(_ sender: UIButton){
        let alert = UIAlertController(title: "Borrar datos del usuario", message: "Vas a borrar los datos del usuario, ¿estás seguro?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: {[weak self] _ in
            //Elimina el profesor de la lista de todos los profesores
            guard let id = self?.user?.id else {
                return
            }
            self?.delete(user: id) {_ in 
                 self?.navigationController?.popViewController(animated: true)
            }
          
            
     
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
    }
    func delete(user id: String, completion: @escaping ServiceCompletion){
        DispatchQueue.global(qos: .background).async {
            guard let userDB = DataBaseManager.shared.user(id: id) else {
                return
            }
            DataBaseManager.shared.delete(user: userDB)
            DispatchQueue.main.async {
                completion(.success(data: nil))
            
        }
    }
}
var user: User?
var usersSameCountry: [User] = []
private var cellTypes = [UserDetailCellType.personalData, UserDetailCellType.contactData, UserDetailCellType.country, UserDetailCellType.map, UserDetailCellType.usersSameCountry]

enum UserDetailCellType: Int {
    case personalData = 0
    case contactData = 3
    case country = 1
    case map = 2
    case usersSameCountry = 4
}

override func viewDidLoad() {
    
    super.viewDidLoad()
    //Do any additional setup after loading the view.
    configure(tableView: tableView)
    configureView(viewName: deleteButton)
    deleteButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
}
private func configureView(viewName: UIView){
    viewName.layer.cornerRadius = 8.0
    viewName.layer.borderWidth = 1
    viewName.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
    viewName.layer.backgroundColor = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
}

}
extension UserDetail: UITableViewDataSource, UITableViewDelegate{
    
    /// Configure table view
    func configure(tableView: UITableView){
        enableCells()
        //Margen inferior del tableview para el boton
        tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: deleteButton.frame.height + 12,right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.allowsSelection = false
        
        
    }
    private func enableCells(){
        //Tipos de celda que puede haber en el tableview
        tableView.register(UINib(nibName: PersonalDataCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PersonalDataCell.cellIdentifier)
        tableView.register(UINib(nibName: ContactDataCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ContactDataCell.cellIdentifier)
        tableView.register(UINib(nibName: CountryCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: CountryCell.cellIdentifier)
        tableView.register(UINib(nibName: MapCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MapCell.cellIdentifier)
        tableView.register(UINib(nibName: UsersSameCountryCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: UsersSameCountryCell.cellIdentifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let actualUser = user else {
            return UITableViewCell()
        }
        switch cellTypes[indexPath.row]{
            
        case .personalData:
            return cellPersonalData(tableView: tableView, indexPath: indexPath, user: actualUser)
            
        case .contactData:
            return cellContactData(tableView: tableView, indexPath: indexPath, user: actualUser)
            
        case .country:
            return cellCountry(tableView: tableView, indexPath: indexPath, user: actualUser)
            
        case .map:
            return cellMap(tableView: tableView, indexPath: indexPath, user: actualUser)
            
        case .usersSameCountry:
            return cellUsersSameCountry(tableView: tableView, indexPath: indexPath, user: actualUser)
        }
        
    }
    func cellPersonalData(tableView: UITableView, indexPath: IndexPath, user: User) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataCell.cellIdentifier, for: indexPath) as? PersonalDataCell else {
            
            return UITableViewCell()
        }
        cell.configureCell(image: user.avatar, name: user.name, age: "\(user.age)", birthdate: user.birthdate, gender: user.gender)
        return cell
    }
    
    func cellContactData(tableView: UITableView, indexPath: IndexPath, user: User) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDataCell.cellIdentifier, for: indexPath) as? ContactDataCell else {
            
            return UITableViewCell()
        }
        cell.configureCell(email: user.email)
        return cell
    }
    func cellCountry(tableView: UITableView, indexPath: IndexPath, user: User) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.cellIdentifier, for: indexPath) as? CountryCell else {
            
            return UITableViewCell()
        }
        cell.configureCell(country: user.country, nationality: user.nationality)
        return cell
    }
    func cellMap(tableView: UITableView, indexPath: IndexPath, user: User) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MapCell.cellIdentifier, for: indexPath) as? MapCell else {
            return UITableViewCell()
        }
        cell.configureCell(latitude: user.latitude, longitude: user.longitude)
        return cell
    }
    private func cellUsersSameCountry(tableView: UITableView, indexPath: IndexPath, user: User) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersSameCountryCell.cellIdentifier, for: indexPath) as? UsersSameCountryCell else {
            return UITableViewCell()
        }
        cell.configureCell(users: usersSameCountry, country: user.country)
        return cell
    }
    
    
    //Tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        switch cellTypes[heightForRowAt.row]{
        case .personalData:
            return PersonalDataCell.cellHeight
        case .contactData:
            return ContactDataCell.cellHeight
        case .country:
            return CountryCell.cellHeight
        case .usersSameCountry:
            return UsersSameCountryCell.cellHeight
            
        case .map:
            return MapCell.cellHeight
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? UsersSameCountryCell, let newUser = cell.nextUser, let oldUser = user else {
            return
        }
        
        self.user = newUser
        let unsortedUsers = usersSameCountry + [oldUser]
        self.usersSameCountry = unsortedUsers.filter{$0.id != newUser.id}.sorted{$0.age < $1.age}
        tableView.reloadData()
        
    }
    
}
//Constrains


