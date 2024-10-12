//
//  CommentsViewModel.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-27.
//

import Foundation

class CommentsViewModel: ObservableObject {
    
    @Published private(set) var comments: [Comment] = []
    @Published var state: ViewState = .idle
    
    private let commentService: CommentServiceProtocol
    
    init(commentService: CommentServiceProtocol) {
        self.commentService = commentService
    }
    
    func fetchComments() {
        self.state = .loading
        do {
            commentService.fetchComments { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let fetchedComments):
                        self.comments = fetchedComments
                        self.state = .success
                    case .failure(let error):
                        self.state = .failure(error)
                    }
                }
            }
        }
    }
}

enum ViewState {
    case idle
    case loading
    case success
    case failure(Error)
}

    

//    func fetchComments() {
//        Task {
//            do {
//                let fetchedComments = try await commentService.fetchComments { result in
//                    switch result {
//                    case .success(let resultComments):
//                        await MainActor.run {
//                            self.comments =
//                        }
//                    }
//                }
//                
//                
//            }
//            catch {
//                await MainActor.run {
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//        
//    }
    
