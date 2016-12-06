//
//  PokemonDao.swift
//  PokeSource
//
//  Created by Jean-Christophe MELIKIAN on 06/12/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import Foundation
import CoreData

class PokemonDao {
    
    class func create(entryNumber:Int32, name:String) {
        if let context = DataManager.shared.objectContext {
            // Equivalent: NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            let p = Pokemon(context: context)
            p.entry_number = entryNumber
            p.name = name
            try? context.save()
        }
    }
    
    class func read() {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            if let pokemons = try? context.fetch(request) {
                for p in pokemons {
                    print(p.name!)
                }
            }
        }
    }
    
    class func findOne(byId: Int32) -> Pokemon? {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            request.predicate = NSPredicate(format: "entry_number==%d", byId)
            if let pokemons = try? context.fetch(request) {
                for p in pokemons {
                    let name: String? = p.name
                    print(name!)
                }
                return pokemons.first
            }
            
        }
        let result: Pokemon = Pokemon()
        result.name = "Unknown"
        result.entry_number = 0
        return result
    }
    
}
