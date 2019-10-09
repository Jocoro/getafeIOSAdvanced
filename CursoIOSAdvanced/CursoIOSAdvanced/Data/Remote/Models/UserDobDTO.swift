//
//  UserDobDTO.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserDobDTO: Codable {
    //hay que decirle como cambiar de tipo string a date
    let date : Date?
    let age : Int?
}
