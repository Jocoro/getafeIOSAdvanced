//
//  NewUserViewController.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {
     @IBOutlet var tableView : UITableView!
  

    //Segunda celda
    // @objc dynamic var email : String?
    //Tercera celda
    //@objc dynamic var gender : String?
    //Cuarta celda
    //@IBOutlet weak var birthdate : UIDatePicker!
    //Quinta celda
    //@objc dynamic var nationality : String?
    //Sexta celda
    //@objc dynamic var country : String?
    //Septima celda
    //@objc dynamic var latitude : String?
    //@objc dynamic var longitude : String?
   
    @IBOutlet weak var addUser : UIButton!
    
    @IBAction func onButtonPressed(_ sender: UIButton){
            let alert = UIAlertController(title: "Add User", message: "add this User?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Add", style: .destructive, handler: {[weak self] _ in
                //Elimina el profesor de la lista de todos los profesores
            
                self?.add(avatar: self?.avatar, firstname: self?.firstname, lastname: self?.lastname, email: self?.email, gender: self?.gender, birthdate: self?.birthdate, country: self?.country, latitude: self?.latitude, longitude: self?.longitude, nationality: self?.nationality){_ in
               print("añadido")
                    self?.navigationController?.popViewController(animated: true)}
                
              
                
         
                
                
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel))
            
            present(alert, animated: true)
        }
    var avatar: String? {
        guard let row = cellTypes.firstIndex(of: .newUserName), let _ = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserNameViewCell else {
            return nil
        }
        return "https://randomuser.me/api/portraits/women/49.jpg"
    }
    var firstname: String? {
        guard let row = cellTypes.firstIndex(of: .newUserName), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserNameViewCell, let firstname = cell.firstName.text else {
            return nil
        }
        
        return firstname
    }
    var lastname: String? {
        guard let row = cellTypes.firstIndex(of: .newUserName), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserNameViewCell, let lastname = cell.lastName.text else {
            return nil
        }
        
        return lastname
    }
    var email: String? {
           guard let row = cellTypes.firstIndex(of: .newUserEmail), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserEmailCell, let email = cell.email.text else {
               return nil
           }
           
           return email
       }
    var gender: String? {
        guard let row = cellTypes.firstIndex(of: .newUserGender), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserGenderCell, let gender = cell.gender else {
            return nil
        }
        
        return gender
    }
    var birthdate: Date? {
        guard let row = cellTypes.firstIndex(of: .newUserBirthdate), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserBirthdateCell  else {
            return nil
        }
        
        return cell.birthdate.date
    }
    var nationality: String? {
        guard let row = cellTypes.firstIndex(of: .newUserNationality), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserNationalityCell, let nationality = cell.nationality else {
            return nil
        }
        
        return nationality
    }
    var country: String? {
        guard let row = cellTypes.firstIndex(of: .newUserCountry), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserCountryCell else {
            return nil
        }
        
        return cell.selectedCountry
    }
    var latitude: String? {
              guard let row = cellTypes.firstIndex(of: .newUserCoordinates), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserCoordinatesCell, let latitude = cell.latitude.text else {
                  return nil
              }
              
              return latitude
          }
    var longitude: String? {
                 guard let row = cellTypes.firstIndex(of: .newUserCoordinates), let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NewUserCoordinatesCell, let longitude = cell.longitude.text else {
                     return nil
                 }
                 
                 return longitude
             }
        func add(avatar: String? = nil,
        firstname: String? = nil,
        lastname: String? = nil,
        email: String? = nil,
        gender: String? = nil,
        birthdate: Date? = nil,
        country: String? = nil,
        latitude:  String? = nil,
        longitude: String? = nil,
        nationality: String? = nil, completion: @escaping ServiceCompletion){
            DispatchQueue.global(qos: .background).async {
                
                DataBaseManager.shared.addUser(avatar: avatar, firstname: firstname, lastname: lastname, email: email, gender: gender, birthdate: birthdate, country: country, latitude: latitude, longitude: longitude, nationality: nationality)
                DispatchQueue.main.async {
                    completion(.success(data: nil))
                
            }
        }
    }
    
    
    
    enum NewUserDCellType: Int {
        case newUserName
        case newUserEmail
        case newUserGender
        case newUserBirthdate
        case newUserNationality
        case newUserCountry
        case newUserCoordinates
    }
    private var cellTypes = [NewUserDCellType.newUserName, NewUserDCellType.newUserEmail, NewUserDCellType.newUserGender,
                             NewUserDCellType.newUserBirthdate, NewUserDCellType.newUserNationality, NewUserDCellType.newUserCountry,
                             NewUserDCellType.newUserCoordinates]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        configure(tableView: tableView)
       
    }
    
  
}
extension NewUserViewController: UITableViewDataSource, UITableViewDelegate{

/// Configure table view
func configure(tableView: UITableView){
     enableCells()
    //Margen inferior del tableview para el boton
    tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: addUser.frame.height + 12,right: 0)
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = 200
    tableView.dataSource = self
    tableView.delegate = self
    tableView.allowsSelection = false
  
    
    
}
    private func enableCells(){
          //Tipos de celda que puede haber en el tableview
          tableView.register(UINib(nibName: NewUserNameViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewUserNameViewCell.cellIdentifier)
        tableView.register(UINib(nibName: NewUserBirthdateCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewUserBirthdateCell.cellIdentifier)
        tableView.register(UINib(nibName: NewUserEmailCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewUserEmailCell.cellIdentifier)
        tableView.register(UINib(nibName: NewUserGenderCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewUserGenderCell.cellIdentifier)
        tableView.register(UINib(nibName: NewUserNationalityCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewUserNationalityCell.cellIdentifier)
         tableView.register(UINib(nibName: NewUserCountryCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewUserCountryCell.cellIdentifier)
         tableView.register(UINib(nibName: NewUserCoordinatesCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewUserCoordinatesCell.cellIdentifier)
      }

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellTypes.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    switch cellTypes[indexPath.row]{
        
    case .newUserName:
        return tableView.dequeueReusableCell(withIdentifier: NewUserNameViewCell.cellIdentifier, for: indexPath)
    case .newUserEmail:
        return tableView.dequeueReusableCell(withIdentifier: NewUserEmailCell.cellIdentifier, for: indexPath)
    case .newUserGender:
        return tableView.dequeueReusableCell(withIdentifier: NewUserGenderCell.cellIdentifier, for: indexPath)
    case .newUserBirthdate:
        return tableView.dequeueReusableCell(withIdentifier: NewUserBirthdateCell.cellIdentifier, for: indexPath)
    case .newUserNationality:
        return tableView.dequeueReusableCell(withIdentifier: NewUserNationalityCell.cellIdentifier, for: indexPath)
    case .newUserCountry:
         return tableView.dequeueReusableCell(withIdentifier: NewUserCountryCell.cellIdentifier, for: indexPath)
    case . newUserCoordinates:
        return tableView.dequeueReusableCell(withIdentifier: NewUserCoordinatesCell.cellIdentifier, for: indexPath)
    
    }
    
}



//Tamaño de cada celda
func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
    switch cellTypes[heightForRowAt.row]{
    case .newUserName:
         return NewUserNameViewCell.cellHeight
    case .newUserEmail:
        return NewUserEmailCell.cellHeight
    case .newUserGender:
        return NewUserGenderCell.cellHeight
    case .newUserBirthdate:
        return NewUserBirthdateCell.cellHeight
    case .newUserNationality:
        return NewUserNationalityCell.cellHeight
    case .newUserCountry:
        return NewUserCountryCell.cellHeight
    case .newUserCoordinates:
        return NewUserCoordinatesCell.cellHeight
 
    }
   
    
}
}
