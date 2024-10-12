//
//  MVVMCommentsApp.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-27.
//

import SwiftUI

@main
struct MVVMCommentsApp: App {
    
    let networkService = NetworkService()
    
    @State private var selectedTab: Int = 0
    @State private var selectedUserId: Int = 1
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                CommentsView(commentService: CommentService(networkService: networkService), selectedTab: $selectedTab, selectedUserId: $selectedUserId)
                    .tabItem {
                        Text("Comments")
                        Image(systemName: "message.badge.fill")
                    }
                    .tag(0)
                UserView(userService: UserService(networkService: networkService), selectedUserId: $selectedUserId)
                    .tabItem {
                        Text("Profile")
                        Image(systemName: "person.fill")
                    }
                    .tag(1)
            }
            
        }
    }
}
