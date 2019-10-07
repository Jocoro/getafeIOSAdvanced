//
//  UserDTO.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation


struct UserDTO: Codable {
    let gender: String?
    let name: UserNameDTO?
    let location : UserLocationDTO?
    let email : String?
    let login : UserLoginDTO?
    let dob : UserDobDTO?
    let registered : UserDobDTO?
    let phone : String?
    let cell : String?
    //let id : UserIdDTO?
    let picture : UserPictureDTO?
    let nat : String?
    
    
    
}
