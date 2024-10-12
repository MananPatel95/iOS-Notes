//
//  CoreDataView.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//

import SwiftUI

struct CoreDataView: View {
    
    @StateObject private var viewModel = CoreDataViewModel()
    @State private var name = ""
    @State private var age = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new person")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age).keyboardType(.numberPad)
                    
                    Button("Save Person") {
                        if let age = Int16(age) {
                            viewModel.addPerson(name: name, age: age)
                            name = ""
                            self.age = ""
                        }
                    }
                }
                
                Section(header: Text("Current People")) {
                    ForEach(viewModel.savedPersons, id: \.self) { person in
                        Text("Name: \(person.name), Age: \(person.age)")
                    }
                }
            }
            .navigationTitle("CoreData")
        }
    }
}

#Preview {
    CoreDataView()
}
