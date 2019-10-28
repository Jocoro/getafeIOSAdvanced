//
//  DataBaseManager.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseManager{
    static let shared = DataBaseManager()
    private init(){}
   private let sortingKey = "birthdate"
    
    
    var users: Results<UserDAO> {
        //Para devolver ordenados los de la base de datos
        //var data = realm.objects(UserDAO.self)
        //data = data.sorted(byKeyPath: sortingKey, ascending: true)
           return realm.objects(UserDAO.self)
       }
    
    //MARK: -Properties
    // Get the default Realm database
     private var realm: Realm {
           return try! Realm()
       }
    
    func save(user: UserDAO){
        try! realm.write {
            realm.add(user, update: .modified)
        }
    }
    
   
    func user(id: String) -> UserDAO? {
        return realm.object(ofType: UserDAO.self, forPrimaryKey: id)
    }
    func deleteAll(){
        try! realm.write{
        realm.deleteAll()
        }
    }
    func delete(user: UserDAO){
        try! realm.write{
        realm.delete(user)
        }
    }
    func addUser(avatar: String? = nil,
    firstname: String? = nil,
    lastname: String? = nil,
    email: String? = nil,
    gender: String? = nil,
    birthdate: Date? = nil,
    country: String? = nil,
    latitude:  String? = nil,
    longitude: String? = nil,
    nationality: String? = nil){
        let uuid = String(Double.random(in: 0...100))
       let userDAO = UserDAO(uuid: uuid, avatar: avatar, firstname: firstname, lastname: lastname, email: email, gender: gender, birthdate: birthdate, country: country, latitude: latitude, longitude: longitude, nationality: nationality)
       save(user: userDAO)
    }
}
extension DataBaseManager {
    var segmentMode: String {
        return "segmentMode"
    }
    // Opciones por defecto
    var getDefaultSegment: Int {
        return UserDefaults.standard.integer(forKey: segmentMode)
    }
    
    func saveDefaultSegment(option: Int){
        UserDefaults.standard.set(option, forKey: segmentMode)
        
    }
    var sortByCountry: String {
        return "sortMode"
    }
    var getDefaultSorting: Bool {
        return UserDefaults.standard.bool(forKey: sortByCountry)
    }
    func changeDefaultSorting(){
        UserDefaults.standard.set(!getDefaultSorting, forKey: sortByCountry)
    }
}
