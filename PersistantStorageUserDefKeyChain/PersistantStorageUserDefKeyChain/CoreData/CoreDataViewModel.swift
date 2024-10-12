//
//  CoreDataViewModel.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//

import Foundation
import CoreData

// 1. Create a Core Data model programmatically

// Create a custom NSPersistentContainer subclass
class CustomPersistentContainer: NSPersistentContainer {
    override class func defaultDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        // Create the model programmatically
        let personEntity = NSEntityDescription()
        personEntity.name = "Person"
        personEntity.managedObjectClassName = NSStringFromClass(Person.self)
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        
        let ageAttribute = NSAttributeDescription()
        ageAttribute.name = "age"
        ageAttribute.type = .integer16
        
        personEntity.properties = [nameAttribute, ageAttribute]
        
        let model = NSManagedObjectModel()
        model.entities = [personEntity]
        
        // Create a custom persistent container with our model
        container = CustomPersistentContainer(name: "PersonModel", managedObjectModel: model)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

// 2. Update Person class to properly subclass NSManagedObject
class Person: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var age: Int16
}

// 3. Create ViewModel to interact with the container
class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedPersons: [Person] = []
    
    init() {
        container = PersistenceController.shared.container
        
        fetchPersons()
    }
    
    func fetchPersons() {
        let request = NSFetchRequest<Person>(entityName: "Person")
        do {
            savedPersons = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching person: \(error.localizedDescription)")
        }
    }
    
    func addPerson(name: String, age: Int16) {
        let newPerson = Person(context: container.viewContext)
        newPerson.age = age
        newPerson.name = name
        saveData()
        fetchPersons()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("error saving: \(error.localizedDescription)")
        }
    }
    
}

