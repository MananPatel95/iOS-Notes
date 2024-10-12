//
//  CommentDetailView.swift
//  MVVMComments-AsyncAwsit
//
//  Created by Manan Patel on 2024-08-31.
//

import Foundation
import SwiftUI

struct CommentDetailView: View {
    private let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(comment.name ?? "N/A")
                .font(.headline)
            Text(comment.email ?? "N/A")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(comment.body ?? "N/A")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
