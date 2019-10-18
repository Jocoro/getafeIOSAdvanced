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
    
    private var usersDB: Array<UserDAO> {
        return Array(DataBaseManager.shared.users)
        
    }
    
    private var getUsersUIFromDB: Array<User>{
        let usersDAO = usersDB
        return getUsersUI(from: usersDAO)
    }
    
    private init() {}
    
    
    func users(completion: @escaping ServiceCompletion){
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let usersUI = self?.getUsersUIFromDB, usersUI.count > 0 {
                // Devolver userDB
                //Conviertes listado de users de la base de dato al modelo de user para las vistas
                
                DispatchQueue.main.async {
                    completion(.success(data: usersUI))
                }
                
            }
            else{
                // LLamar al servicio y guardar usuarios en base de datos
                self?.usersForceUpdate(completion: completion)
            }
        }
        
        
    }
    
    func usersForceUpdate(completion: @escaping ServiceCompletion){
        // LLamar al servicio y guardar usuarios en base de datos
        DispatchQueue.global(qos: .background).async{
            
            
            ApiManager.shared.fetchUsers() { [weak self] result in
                switch result{
                case .success(let data):
                    guard let users = data as? UsersDTO else{
                        DispatchQueue.main.async{
                            completion(.failure(msg: "mensaje de error generico"))
                        }
                        return
                    }
                    
                    //Eliminar los datos
                    DataBaseManager.shared.deleteAll()
                    //guardar los datos
                    self?.save(users: users)
                    
                    let usersUI = self?.getUsersUIFromDB
                    DispatchQueue.main.async {
                        completion(.success(data: usersUI))
                    }
                case .failure(let msg):
                    print("Fallo al obtener usuarios del servicio: \(msg)")
                    DispatchQueue.main.async {
                        completion(.failure(msg: msg))
                    }
                }
                
            }
        }
        
    }
    
    
    func user(id: String, completion: @escaping ServiceCompletion) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let userDAO = DataBaseManager.shared.user(id: id) else{
                
                DispatchQueue.main.async {
                    completion(.failure(msg: "No se ha encontrado el usuario"))
                }
                return
            }
            let user = self?.getUserUI(from: userDAO)
            DispatchQueue.main.async {
                completion(.success(data: user))
            }
        }
        
    }
    
    
    // listado de usuarios de la base de datos
    
    //Carga los datos de un usuario
    
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
                             longitude: user.location?.coordinates?.longitude,
                             nationality : user.nat)
        DataBaseManager.shared.save(user: userDB)
    }
    
    private func getUserUI(from userDAO: UserDAO) -> User {
        
        return User(id: userDAO.uuid,
                    avatar: userDAO.avatar,
                    firstName: userDAO.firstName,
                    lastName: userDAO.lastName,
                    email: userDAO.email,
                    birthdate: userDAO.birthdate,
                    country: userDAO.country,
                    nationality: userDAO.nationality,
                    latitude: userDAO.latitude,
                    longitude: userDAO.longitude,
                    gender: userDAO.gender)
        
    }
    
    private func getUsersUI(from usersDAO: Array<UserDAO>) -> Array<User> {
        //Para ordenar en el interfaz de usuario
        if DataBaseManager.shared.getDefaultSorting {
            return usersDAO.compactMap { getUserUI(from: $0)}.sorted {$0.country ?? "" < $1.country ?? ""}
        } else{
            return usersDAO.compactMap { getUserUI(from: $0)}.sorted {$0.age < $1.age}
        }
        
    }
    
}



extension DataManager {
    //Opciones por defecto
    var defaultSegment: Int{
        return DataBaseManager.shared.getDefaultSegment
    }
    
    func saveDefaultSegment(option: Int){
        DataBaseManager.shared.saveDefaultSegment(option: option)
        
    }
    var defaultSorting: Bool{
        return DataBaseManager.shared.getDefaultSorting
    }
    func changeDefaultSorting(){
        DataBaseManager.shared.changeDefaultSorting()
    }
}
