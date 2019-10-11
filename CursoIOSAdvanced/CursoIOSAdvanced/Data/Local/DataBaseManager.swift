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
    
    //MARK: -Properties
    // Get the default Realm database
    private let realm = try! Realm()
    
    func save(user: UserDAO){
        try! realm.write {
            realm.add(user, update: .modified)
        }
    }
    
    func users() -> Results<UserDAO> {
        return realm.objects(UserDAO.self)
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
    // Opciones por defecto
    func getDefaultOptions() -> Int {
        let preferences = UserDefaults.standard
        return preferences.integer(forKey: "SegmentedMode")
          }
    func changeDefaultOptions(){
        let preferences = UserDefaults.standard
        let actualValue = preferences.integer(forKey: "SegmentedMode")
        switch actualValue {
        case 0:
        preferences.set(1, forKey: "SegmentedMode")
        default:
        preferences.set(0, forKey: "SegmentedMode")
        }
       
    }
}
