//
//  UserLocationDTO.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
struct UserLocationDTO: Codable {
    let street : StreetDTO?
    let city : String?
    let state : String?
    let country : String?
    //let postcode : Int?
    let coordinates : CoordinatesDTO?
    let timezone : TimezoneDTO?
    
}
