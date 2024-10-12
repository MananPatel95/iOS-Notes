//
//  ContentView.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//

import SwiftUI

struct UserDefaultsView: View {
    private var viewModel = UserDefaultsViewModel()
    
    @State private var emailValue = ""
    @AppStorage("email") var savedEmailValue: String = "NA"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                
                Group {
                    Text("UserDefaults").font(.headline)
                    TextField("Enter Email", text: $emailValue)
                    
                    
                    Button("Save Email") {
                        savedEmailValue = emailValue
                    }
                    
                    Text("Saved Email Value: \(savedEmailValue)")
                }
                .padding(8)
        
                Spacer()
            }
            .padding()
            .navigationTitle("UserDefaults")
        }
    }
}

#Preview {
    UserDefaultsView()
}
