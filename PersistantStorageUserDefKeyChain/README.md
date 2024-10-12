# Persistant Storage Methods iOS
What are the forms of persistant storage in iOS app?

## User Defaults 
Preferences, flags, small sets of data which are tied to some configuration
- In SwiftUI, we can use @AppStorage, this will save a .plist file containg this key value pair
- BUT this can be exposed publically, used for non-sensitive, non-critical state data
- Data is stored in the sandbox area and will be removed when app is uninstalled

## KeyChain 
Best place to store small secrets, passwords, cryptographic keys
- In SwiftUI, we can use @KeyChainStorage (custom property wrapper)
- Data is stored in an encrypted database, info in keychain is not deleted, which is outside app scope

## CoreData
- Object-oriented database framework for iOS
- Allows you to define your data model in a visual editor or manually
- Provides features like data validation, versioning, and migration
- Good for complex data models and relationships
- In SwiftUI, we can use @FetchRequest property wrapper to fetch and display CoreData entities

## SwiftData
- Designed to work seamlessly with SwiftUI
- Simplifies data persistence compared to CoreData
- Uses Swift's native language features like property wrappers and result builders
- Automatically generates database schema from your Swift types
- Uses @Model macro to define persistable types
- @Query property wrapper for fetching data

| Framework | Screenshot |
|-----------|------------|
| SwiftData | <img src="https://github.com/user-attachments/assets/62ce9750-b861-4169-8470-89ea996cb417" width="20%" /> |
| CoreData | <img src="https://github.com/user-attachments/assets/dc7a42d6-4e61-4d43-8239-a7bf31b72cd0" width="20%" /> |
| Keychain | <img src="https://github.com/user-attachments/assets/ce84d9ec-2c77-4338-b08c-68b417157fc9" width="20%" /> |
| UserDefaults | <img src="https://github.com/user-attachments/assets/cb727e8b-502c-4a5c-9978-b9e60b340ab1" width="20%" /> |
