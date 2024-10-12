//
//  UserService.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-28.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUserData(id: String, 
                       completion: @escaping((Result<User, NetworkError>) -> ()))
}

class UserService: UserServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchUserData(id: String, completion: @escaping ((Result<User, NetworkError>) -> ())) {
        networkService.fetchData(with: User.self, 
                                 from: APIEndpoints.users(id),
                                 completion: completion)
    }
}
