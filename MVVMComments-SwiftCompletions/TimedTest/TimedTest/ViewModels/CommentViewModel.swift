//
//  CommentViewModel.swift
//  TimedTest
//
//  Created by Manan Patel on 2024-09-05.
//

import Foundation

@MainActor
class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var error: NetworkingError?
    private let commentService: CommentServiceProtocol
    
    init(error: NetworkingError? = nil, commentService: CommentServiceProtocol = CommentService()) {
        self.error = error
        self.commentService = commentService
    }
    
    func fetchComments() async {
        do {
            comments = try await commentService.fetchComments()
        } catch {
            if let error = error as? NetworkingError {
                self.error = error
            } else {
                self.error = NetworkingError.unkownError(error)
            }
        }
    }
}
