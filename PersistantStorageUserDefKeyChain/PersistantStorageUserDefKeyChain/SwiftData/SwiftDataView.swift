//
//  SwiftDataView.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//

import SwiftUI
import SwiftData

// 1. Define a SwiftData model using @Model
@Model
class PersonSwift {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// 2. We can directly interact and modify the data from the SwiftUI view
struct SwiftDataView: View {
    
    // We use @Envionment(\.modelContext) to access model context
    @Environment(\.modelContext) private var modelContext
    // @Query fetches data automatically
    @Query private var people: [PersonSwift]
    
    @State private var name = ""
    @State private var age = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add a person")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age).keyboardType(.numberPad)

                    Button("Save Person") {
                        addPerson()
                    }
                }
                
                Section(header: Text("People")) {
                    ForEach(people) { person in
                        Text("Name: \(person.name), Age: \(person.age)")
                    }
                    .onDelete(perform: deletePeople)
                }
            }
            .navigationTitle("SwiftData")
        }
        
    }
    
    private func addPerson() {
        guard let age = Int(age) else { return }
        let newPerson = PersonSwift(name: name, age: age)
        modelContext.insert(newPerson)
        
        name = ""
        self.age = ""
    }
    
    private func deletePeople(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(people[index])
        }
    }
}

#Preview {
    SwiftDataView()
}
