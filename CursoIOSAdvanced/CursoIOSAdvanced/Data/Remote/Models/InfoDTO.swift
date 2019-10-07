//
//  InfoDTO.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct InfoDTO: Codable {
    let seed : String?
    let count : Int?
    let page : Int?
    let version : String?
    private enum CodingKeys: String, CodingKey {
        case seed
        case count = "results"
        case page
        case version
    }
}
