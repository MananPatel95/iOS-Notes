//
//  PersistantStorageUserDefKeyChainApp.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//


// Persistant Storage
// What are the forms of persistant storage in iOS app?

// User Defaults: Preferences, flags, small sets of data which are tied to some configuration
// - In SwiftUI, we can use @AppStorage, this will save a .plist file containg this key value pair
// - BUT this can be exposed publically, used for non-sensitive, non-critical state data
// - Data is stored in the sandbox area and will be removed when app is uninstalled

// KeyChain: Best place to store small secrets, passwords, cryptographic keys
// - In SwiftUI, we can use @KeyChainStorage (custom property wrapper)
// - Data is stored in an encrypted database, info in keychain is not deleted, which is outside app scope

// CoreData:
// - Object-oriented database framework for iOS
// - Allows you to define your data model in a visual editor or manually
// - Provides features like data validation, versioning, and migration
// - Good for complex data models and relationships
// - In SwiftUI, we can use @FetchRequest property wrapper to fetch and display CoreData entities

// SwiftData:
// - Designed to work seamlessly with SwiftUI
// - Simplifies data persistence compared to CoreData
// - Uses Swift's native language features like property wrappers and result builders
// - Automatically generates database schema from your Swift types
// - Uses @Model macro to define persistable types
// - @Query property wrapper for fetching data

import SwiftUI

@main
struct PersistantStorageUserDefKeyChainApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                UserDefaultsView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("UserDefaults")
                    }
                KeyChainView()
                    .tabItem {
                        Image(systemName: "key.fill")
                        Text("KeyChain")
                    }
                CoreDataView()
                    .tabItem {
                        Image(systemName: "server.rack")
                        Text("CoreData")
                    }
                SwiftDataView()
                    .tabItem {
                        Image(systemName: "swiftdata")
                        Text("SwiftData")
                    }
            }
        }
        .modelContainer(for: PersonSwift.self)
    }
}
