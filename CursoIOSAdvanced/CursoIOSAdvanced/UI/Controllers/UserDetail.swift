//
//  UserDetail.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
enum UserDetailCellType: Int {
    case personalData = 0
    case contactData = 3
    case country = 1
    case map = 2
    case usersSameCountry = 4
}
class UserDetail: UIViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet var deleteButton : UIButton!
    
    @IBAction func onButtonPressed(_ sender: UIButton){
        let alert = UIAlertController(title: "Borrar datos del usuario", message: "Vas a borrar los datos del usuario, ¿estás seguro?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: {[weak self] _ in
            //Elimina el profesor de la lista de todos los profesores
            guard let id = self?.user?.id, let userDB = DataBaseManager.shared.user(id: id) else {
                return
            }
            DataBaseManager.shared.delete(user: userDB)
            
            self?.navigationController?.popViewController(animated: true)
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
    }
    var user: User?
    var usersSameCountry: [User] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure(tableView: tableView)
        
    }
    
}
extension UserDetail: UITableViewDataSource, UITableViewDelegate {
    /// Configure table view
    func configure(tableView: UITableView){
        enableCells()
        //Margen inferior del tableview para el boton
        tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: deleteButton.frame.height + 12,right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        tableView.dataSource = self
        tableView.delegate = self
        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let actualUser = user else {
            return UITableViewCell()
        }
        switch indexPath.row{
            
        case UserDetailCellType.personalData.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataCell.cellIdentifier, for: indexPath) as? PersonalDataCell else {
                           
                           return UITableViewCell()
                   }
                   cell.configureCell(image: actualUser.avatar, name: actualUser.name, age: "\(actualUser.age)", birthdate: actualUser.birthdate, gender: actualUser.gender)
                   return cell
            
            
        case UserDetailCellType.contactData.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDataCell.cellIdentifier, for: indexPath) as? ContactDataCell else {
                    
                    return UITableViewCell()
            }
            cell.configureCell(email: actualUser.email)
            return cell
        case UserDetailCellType.country.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.cellIdentifier, for: indexPath) as? CountryCell else {
                    
                    return UITableViewCell()
            }
            cell.configureCell(country: actualUser.country, nationality: actualUser.nationality)
            return cell
            
        case UserDetailCellType.map.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MapCell.cellIdentifier, for: indexPath) as? MapCell else {
                    return UITableViewCell()
            }
            cell.configureCell(latitude: actualUser.latitude, longitude: actualUser.longitude)
            return cell
       
        case UserDetailCellType.usersSameCountry.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersSameCountryCell.cellIdentifier, for: indexPath) as? UsersSameCountryCell else {
                    return UITableViewCell()
            }
            cell.configureCell(users: usersSameCountry)
            return cell
            default:
                       return UITableViewCell()
        }
        
        
    }
    func cellDesign(prototypeCell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell{
        let cellType = type(of: prototypeCell)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(cellType)", for: indexPath) as? PersonalDataCell,
            let userCell = user else {
                
                return UITableViewCell()
        }
        cell.configureCell(image: userCell.avatar, name: userCell.name, age: "\(userCell.age)", birthdate: userCell.birthdate, gender: userCell.gender)
        return cell
        
        
    }
    //Tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        switch heightForRowAt.row{
        case UserDetailCellType.personalData.rawValue:
            return 160
        case UserDetailCellType.contactData.rawValue:
            return 44
        case UserDetailCellType.country.rawValue:
            return 44
        case UserDetailCellType.usersSameCountry.rawValue:
            return 400
        default:
            return 200
        }
        
    }
}
//Constrains


