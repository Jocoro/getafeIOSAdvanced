//
//  ApiManager.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
enum ServiceResult{
    case success(data: Any?)
    case failure(msg: String)
}
typealias ServiceCompletion = (_ results: ServiceResult) -> ()

class ApiManager {
    // MARK: - Singleton declaration
      static let shared = ApiManager()
      private init() {}
    
    private let numUsers: Int = 100
    
    func fetchUsers(completion: ServiceCompletion){
        //Llamar al servicio
       
    
        //Devolver datos
        completion(.success(data: "BIIIEN"))
    }
    private func testLoadUsersJson() -> UsersDTO? {
        if let path = Bundle.main.path(forResource: "users", ofType: "json"){
            do{
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            }
            catch{
                
            }
        }
        return UsersDTO()
    }
}


// Datos de prueba

