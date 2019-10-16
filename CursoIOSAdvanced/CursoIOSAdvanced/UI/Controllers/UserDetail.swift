//
//  UserDetail.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
enum UserDetailCellType: Int {
    case personalData
    case contactData
    case country
    case map
}
class UserDetail: UIViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet var deleteButton : UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           configure(tableView: tableView)
           }
    
}
extension UserDetail: UITableViewDataSource, UITableViewDelegate {
    /// Configure table view
    func configure(tableView: UITableView){
        //Tipos de celda que puede haber en el tableview
        tableView.register(UINib(nibName: PersonalDataCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PersonalDataCell.cellIdentifier)
        tableView.register(UINib(nibName: ContactDataCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ContactDataCell.cellIdentifier)
            tableView.register(UINib(nibName: CountryCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: CountryCell.cellIdentifier)
            tableView.register(UINib(nibName: MapCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MapCell.cellIdentifier)
        //Margen inferior del tableview para el boton
        tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: deleteButton.frame.height + 12,right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        
        case UserDetailCellType.personalData.rawValue:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataCell.cellIdentifier, for: indexPath) as? PersonalDataCell,
        let userCell = user else {
            
            return UITableViewCell()
        }
        
        cell.configureCell(image: userCell.avatar, name: userCell.name, age: "\(String(userCell.age))", birthdate: userCell.birthdate)
        return cell
            
        case UserDetailCellType.contactData.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDataCell.cellIdentifier, for: indexPath) as? ContactDataCell,
                   let userCell = user else {
                       
                       return UITableViewCell()
                   }
            cell.configureCell(email: userCell.email)
                   return cell
        case UserDetailCellType.country.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.cellIdentifier, for: indexPath) as? CountryCell,
                            let userCell = user else {
                                
                                return UITableViewCell()
                            }
                     cell.configureCell(country: userCell.country)
                            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataCell.cellIdentifier, for: indexPath) as? PersonalDataCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        
    }
    func cellDesign(type: Int){
        print(UserDetailCellType(rawValue: type).self)
    }
    //Tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        switch heightForRowAt.row{
        case UserDetailCellType.personalData.rawValue:
            return 140
               case UserDetailCellType.contactData.rawValue:
            return 44
        case UserDetailCellType.country.rawValue:
            return 44
        default:
            return 44
        }
    
    }
}
//Constrains


