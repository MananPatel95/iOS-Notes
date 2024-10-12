//
//  MVVMComments_AsyncAwsitApp.swift
//  MVVMComments-AsyncAwsit
//
//  Created by Manan Patel on 2024-08-31.
//

import SwiftUI

@main
struct MVVMComments_AsyncAwsitApp: App {
    var body: some Scene {
        WindowGroup {
            TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                    content:  {
                ListView()
                    .tabItem {
                        Image(systemName: "bubble.fill")
                        Text("Comments")
                    }.tag(2)
                Text("Tab Content 2")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Comments")
                    }.tag(2)
            })
        }
    }
}
