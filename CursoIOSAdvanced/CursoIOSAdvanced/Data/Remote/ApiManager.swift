//
//  ApiManager.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 07/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import Alamofire
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
    private let url: String = "https://randomuser.me/api"
    private let serviceResultDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    private let keyResults = "results"
    
    private var testLoadUsersJson: UsersDTO? {
        // Llamar al servicio
        if let path = Bundle.main.path(forResource: "users", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                return try decoder.decode(UsersDTO.self, from: jsonData)
            }
            catch let error {
                print("parse error: \(error.localizedDescription)")
                return nil
            }
        }
        else {
            print("Invalid filename/path.")
            return nil
        }
    }
    
    func fetchUsers(completion: @escaping ServiceCompletion){
        //Llamar al servicio
        //ALAMOFIRE
        // 1 - create url
        //let path1 = "https://randomuser.me/api/?results=100"
        //let path2 = Bundle.main.path(forResource: "users", ofType: "json")
        //los parametros los he definido arriba: results porque se tiene que guardar como results y el numero de usuarios
        //que se piden. Al poner .queryString se piden al link https://randomuser.me/api/?keyResults=numUsers
        Alamofire.request(url, method: .get, parameters: [keyResults:numUsers],encoding: URLEncoding.queryString).response { [weak self] response in
            if let responseData = response.data{
                let decoder = JSONDecoder()
                              let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = self?.serviceResultDateFormat
                              decoder.dateDecodingStrategy = .formatted(dateFormatter)
                              let users = try? decoder.decode(UsersDTO.self, from: responseData)
                
                completion(.success(data: users))
            }
            else{
                completion(.failure(msg: "Error en la petición al servicio"))
            }
              
                
                //self?.writeToFile(data: Data(json, fileName: "users")

               
               
            
        }
       
        //Usuarios de prueba
       // let users = testLoadUsersJson
        //completion(.success(data: users))
        
    }
    //Devolver datos
    //completion(.success(data: "BIIIEN"))
  
}

    //Download using alamofire
     






// Datos de prueba

