//
//  Comment.swift
//  TimedTest
//
//  Created by Manan Patel on 2024-09-05.
//

import Foundation

struct Comment: Codable, Equatable {
    let postId: Int
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}
