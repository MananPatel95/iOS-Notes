//
//  CommentViewModel.swift
//  MVVMComments-AsyncAwsit
//
//  Created by Manan Patel on 2024-08-31.
//

import Foundation

@MainActor
class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var error: Error?
    
    private let commentService: CommentServiceProtocol
    
    init(error: Error? = nil, commentService: CommentServiceProtocol = CommentService()) {
        self.error = error
        self.commentService = commentService
    }
    
    func fetchComments() async {
        do {
            self.comments = try await commentService.fetchComments()
        } catch {
            if let networkingError = error as? NetworkingError {
                self.error = error
            } else {
                self.error = error
            }
        }
    }
    
}
