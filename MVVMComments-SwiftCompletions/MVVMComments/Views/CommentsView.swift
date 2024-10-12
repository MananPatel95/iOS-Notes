//
//  HomeView.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-27.
//

import SwiftUI

struct CommentsView: View {
    @StateObject private var viewModel: CommentsViewModel
    @Binding private var selectedTab: Int
    @Binding private var selectedUserId: Int
    
    init(commentService: CommentServiceProtocol, selectedTab: Binding<Int>, selectedUserId: Binding<Int>) {
        _viewModel = StateObject(wrappedValue: CommentsViewModel(commentService: commentService))
        _selectedTab = selectedTab
        _selectedUserId = selectedUserId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView()
                case .success:
                    List {
                        ForEach(viewModel.comments) { comment in
                            NavigationLink(destination: CommentDetailView(comment: comment,
                                                                          selectedTab: $selectedTab,
                                                                          selectedUserId: $selectedUserId)) {
                                VStack(alignment: .leading) {
                                    Text(comment.name ?? "Name")
                                    Text(comment.email ?? "Email")
                                }
                            }
                        }
                    }
                case .failure(let error):
                    Text("Failed with error: \(error.localizedDescription)")
                    Button {
                        viewModel.fetchComments()
                    } label: {
                        Text("Retry")
                    }

                }
                
            }
            .navigationTitle("Comments")
            .onAppear {
                viewModel.fetchComments()
            }
        }
    }
}

//#Preview {
//    CommentsView()
//}
