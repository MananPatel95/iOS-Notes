//
//  CommentService.swift
//  TimedTest
//
//  Created by Manan Patel on 2024-09-05.
//

import Foundation

protocol CommentServiceProtocol {
    func fetchComments() async throws -> [Comment]
}

class CommentService: CommentServiceProtocol {
    private let endpoint: String = "/comments"
    private let networkManager: NetworkingManagerProtcol
    
    init(networkManager: NetworkingManagerProtcol = NetworkingManager()) {
        self.networkManager = networkManager
    }
    
    func fetchComments() async throws -> [Comment] {
        return try await networkManager.fetch(string: endpoint)
    }
}
