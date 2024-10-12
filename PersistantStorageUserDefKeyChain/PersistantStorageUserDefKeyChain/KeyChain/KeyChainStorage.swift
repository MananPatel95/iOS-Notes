//
//  KeyChainStorage.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//

import Foundation
import SwiftUI
import KeychainAccess

@propertyWrapper
struct KeyChainStorage: DynamicProperty {
    let key: String
    @State private var value: String
    
    init(wrappedValue: String = "",_ key: String) {
        self.key = key
        let initialValue = (try? Keychain().get(key)) ?? wrappedValue
        self._value = State(initialValue: initialValue)
    }
    
    var wrappedValue: String {
        get { value }
        
        nonmutating set {
            value = newValue
            do {
                try Keychain().set(value, key: key)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
    }
}
