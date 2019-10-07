//
//  UserLoginDTO.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
struct UserLoginDTO: Codable {
    let uuid : String?
    let username : String?
    let password : String?
    let salt : String?
    let md5 : String?
    let shal : String?
    let sha256 : String?
}
