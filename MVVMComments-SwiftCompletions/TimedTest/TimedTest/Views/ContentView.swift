//
//  ContentView.swift
//  TimedTest
//
//  Created by Manan Patel on 2024-09-05.
//

// Class vs Struct
// MyPlayGround.swift

// Concurrency
// Concurrency.swift
//
// Notifications (Delegates, KVO)
// Protocols
// Testing
// API Call App

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CommentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("\(viewModel.comments.count)")
                List(viewModel.comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        Text(comment.name ?? "NA").font(.headline)
                        Text(comment.email ?? "NA").font(.subheadline)
                    }
                    .padding()
                }
            }
            .task {
                await viewModel.fetchComments()
            }
        }
    }
}

#Preview {
    ContentView()
}


