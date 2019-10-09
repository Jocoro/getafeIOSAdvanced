//
//  UserDAO.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import RealmSwift

class UserDAO: Object {
    @objc dynamic var gender : String?
    @objc dynamic var firstName : String?
    @objc dynamic var lastName : String?
    @objc dynamic var country : String?
    @objc dynamic var latitude : String?
    @objc dynamic var longitude : String?
    @objc dynamic var email : String?
    @objc dynamic var uuid : String = ""
    @objc dynamic var birthdate : Date?
    @objc dynamic var avatar : String?
    @objc dynamic var nationality : String?
    
   
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    convenience init(uuid: String, avatar: String? = nil,
                     firstname: String? = nil,
                     lastname: String? = nil,
                     email: String? = nil,
                     gender: String? = nil,
                     birthdate: Date? = nil,
                     country: String? = nil,
                     latitude:  String? = nil,
                     longitude: String? = nil,
                     nationality: String? = nil){
        self.init()
        self.gender = gender
        firstName = firstname
        lastName = lastname
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.email = email
        self.uuid = uuid
        self.birthdate = birthdate
        self.avatar = avatar
        self.nationality = nationality
    }
}
