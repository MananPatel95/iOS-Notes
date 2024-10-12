//
//  CommentDetailView.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-27.
//

import Foundation
import SwiftUI

struct CommentDetailView: View {
    let comment: Comment
    @Binding var selectedTab: Int
    @Binding var selectedUserId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(comment.name ?? "")
            Text(comment.email ?? "")
            Text(comment.body ?? "")
            
            Button(action: {
                selectedTab = 1
                selectedUserId = comment.id ?? -1
            }) {
                Text("View Profile")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}


