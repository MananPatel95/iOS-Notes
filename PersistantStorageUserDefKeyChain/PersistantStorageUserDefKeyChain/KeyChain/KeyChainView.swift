//
//  KeyChainView.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//

import SwiftUI

struct KeyChainView: View {
    @State private var passwordValue = ""
    @KeyChainStorage("password") var savedPasswordValue: String = "NA"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                
                Group {
                    Text("KeyChain Wrapper").font(.headline)
                    TextField("Enter Password", text: $passwordValue)
                    
                    
                    Button("Save Password") {
                        savedPasswordValue = passwordValue
                    }
                    
                    Text("Saved Password Value: \(savedPasswordValue)")
                }
                .padding(8)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Keychain")
        }
    }
}
