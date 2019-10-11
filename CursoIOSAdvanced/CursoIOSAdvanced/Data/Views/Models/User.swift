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
        var userName = ""
        if let userFirstName = firstName{
            userName += userFirstName
            }
        if let userLastName = lastName {
            userName += (userName.count > 0 ? " \(userLastName)" : userLastName)
        }
        return "\(userName)"
    }
    var age: Int {
        guard let birthdate = birthdate,
            let age = Calendar.current.dateComponents([.year], from: birthdate, to: Date()).year else{
        return 0
        }
        return age
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
