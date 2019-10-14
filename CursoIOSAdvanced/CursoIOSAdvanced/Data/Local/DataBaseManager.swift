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
   
    
    
    var users: Results<UserDAO> {
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
}
