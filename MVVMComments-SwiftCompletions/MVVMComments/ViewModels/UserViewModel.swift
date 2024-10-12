//
//  UserViewModel.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-29.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published private(set) var user: User?
    @Published var state: ViewState = .idle
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func fetchUserData(id: String) {
        self.state = .loading
        
        userService.fetchUserData(id: id) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let user):
                    self.user = user
                    self.state = .success
                case .failure(let error):
                    self.state = .failure(error)
                }
            }
        }
    }
}
