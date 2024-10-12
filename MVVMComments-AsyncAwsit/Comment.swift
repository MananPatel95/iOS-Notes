//
//  Comment.swift
//  MVVMComments-AsyncAwsit
//
//  Created by Manan Patel on 2024-08-31.
//

import Foundation

struct Comment: Decodable {
    let id: String
    let postId: Int
    let name: String?
    let email: String?
    let body: String?
}
