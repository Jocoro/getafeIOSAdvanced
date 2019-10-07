//
//  DataManager.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 04/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation


class DataManager {
    // MARK: - Singleton declaration
    static let shared = DataManager()
    private init() {}
    
    
    func users(completion: ServiceCompletion){
        let users = usersDB()
        if users.count > 0 {
            // Devolver userDB
            completion(.success(data: users))
        }
        else{
            // LLamar al servicio y guardar usuarios en base de datos
            usersForceUpdate(completion: completion)
        }
        
    }
    
    func usersForceUpdate(completion: ServiceCompletion){
        // LLamar al servicio y guardar usuarios en base de datos
        ApiManager.shared.fetchUsers() { result in
            switch result{
            case .success(let data):
                guard let users = data as? UsersDTO else{
                    return completion(.failure(msg: "mensaje de error generico"))
                }
                
                //Eliminar los datos
                DataBaseManager.shared.deleteAll()
                //guardar los datos
                save(users: users)
                completion(.success(data: users))
                
            case .failure(let msg):
                print("Fallo al obtener usuarios del servicio: \(msg)")
                completion(.failure(msg: msg))
            }
            
        }
        
    }
    // listado de usuarios de la base de datos
    private func usersDB() -> Array<UserDAO> {
        return Array(DataBaseManager.shared.users())
        
    }
    //Carga los datos de un usuario
    private func user(id: String) -> UserDAO?{
        return DataBaseManager.shared.user(id: id)
    }
    private func save(users: UsersDTO){
        guard let usersToSave = users.users else {
            return
        }
        usersToSave.forEach{save(user: $0)}
        
    }
    private func save(user: UserDTO){
        guard let userId = user.login?.uuid else {
            return
        }
        let userDB = UserDAO(uuid: userId,
                             avatar: user.picture?.large,
                             firstname: user.name?.first,
                             lastname: user.name?.last,
                             email: user.email,
                             gender: user.gender,
                             birthdate: user.dob?.date,
                             country: user.location?.country,
                             latitude: user.location?.coordinates?.latitude,
                             longitude: user.location?.coordinates?.longitude)
        DataBaseManager.shared.save(user: userDB)
    }
    
}
