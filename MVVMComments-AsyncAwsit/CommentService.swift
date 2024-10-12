//
//  CommentService.swift
//  MVVMComments-AsyncAwsit
//
//  Created by Manan Patel on 2024-08-31.
//

import Foundation

protocol CommentServiceProtocol {
    func fetchComments() async throws -> [Comment]
}

class CommentService: CommentServiceProtocol {
    
    private let networkManager: NetworkRequestProtocol
    private let baseURL =  URL(string:"https://jsonplaceholder.typicode.com/")!
    
    init(networkManager: NetworkRequestProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchComments() async throws -> [Comment] {
        let endpoint = Endpoint(baseURL: baseURL,
                                path: "comments")
        return try await networkManager.fetchData(endpoint)
    }
    
}
