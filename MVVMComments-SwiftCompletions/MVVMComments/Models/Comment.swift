//
//  Comment.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-27.
//

import Foundation

struct Comment: Decodable, Identifiable {
    let id: Int?
    let postID: Int?
    let name: String?
    let email: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
