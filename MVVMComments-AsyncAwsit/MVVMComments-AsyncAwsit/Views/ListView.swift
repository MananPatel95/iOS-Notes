//
//  ListView.swift
//  MVVMComments-AsyncAwsit
//
//  Created by Manan Patel on 2024-08-31.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel: CommentViewModel = CommentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: CommentDetailView(comment: comment)) {
                            VStack(alignment: .leading){
                                Text(comment.name ?? "NA").font(.headline)
                                Text(comment.email ?? "NA").font(.subheadline)
                            }
                        
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchComments()
            }
            .alert("Error", isPresented: .constant(viewModel.error != nil), actions: {
                Button("OK") {}
            }, message: {
                Text(viewModel.error?.localizedDescription ?? "Unknown error")
            })
            .navigationTitle("Comments")
        }
    }
}

#Preview {
    ListView()
}
