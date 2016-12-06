//
//  DataManager.swift
//  MyFirstCoreData
//
//  Created by Jean-Christophe MELIKIAN on 16/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    public static let shared = DataManager()
    
    public var objectContext: NSManagedObjectContext?
    
    private override init() {
        if let modelUrl = Bundle.main.url(forResource: "PokeSource", withExtension: "momd") {
            if let model = NSManagedObjectModel(contentsOf: modelUrl) {
                
                let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                
                if let dbURL = FileManager.documentURL(childPath: "pokedex.db") {
                    print(dbURL)
                    
                    // '_' is a keyword meaning that i don't care about the value
                    _ = try? persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbURL, options: nil)
                    
                    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                    context.persistentStoreCoordinator = persistentStoreCoordinator
                    self.objectContext = context
                }
            }
        }
    }
}
