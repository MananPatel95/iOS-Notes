//
//  CommentService.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-28.
//

import Foundation

protocol CommentServiceProtocol {
    func fetchComments(completion: @escaping(Result<[Comment], NetworkError>) -> ())
}

class CommentService: CommentServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchComments(completion: @escaping (Result<[Comment], NetworkError>) -> ()) {
        networkService.fetchData(with : [Comment].self,
                                 from: APIEndpoints.comments,
                                 completion: completion)
    }

}
