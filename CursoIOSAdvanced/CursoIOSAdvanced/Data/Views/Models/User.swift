//
//  User.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 08/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

class User {
    let id: String
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let email: String?
    let birthdate: Date?
    let country: String?
    let nationality: String?
    
    var name: String {
        return "\(String(describing: firstName)) \(String(describing: lastName))"
    }
    var age: Int {
        if let birthdate = birthdate{
        return Calendar.current.dateComponents([.year], from: birthdate, to: Date()).year ?? 0
        }
        else{
            return 0
        }
    }
    
    init(id: String, avatar: String? = nil, firstName: String? = nil, lastName: String? = nil,
                     email: String? = nil, birthdate: Date? = nil, country: String? = nil, nationality: String? = nil){
        
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.email = email
        self.birthdate  = birthdate
        self.country = country
        self.nationality = nationality
        
    }
    
}
