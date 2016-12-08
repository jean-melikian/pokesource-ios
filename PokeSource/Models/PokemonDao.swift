//
//  PokemonDao.swift
//  PokeSource
//
//  Created by Jean-Christophe MELIKIAN on 06/12/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import Foundation
import CoreData

class PokemonDao : NSObject {
    var pokedexCache:Array<Pokemon>
    
    public static let shared = PokemonDao()
    
    private override init() {
        pokedexCache = PokemonDao.findAll()!
    }

    func upsertOne(entryNumber:Int32, name:String, typeA:String = "None", typeB:String = "None") {
        if let p = findOne(byId: entryNumber) {
            p.name = name
            p.typeA = typeA
            p.typeB = typeB
        } else {
            if let context = DataManager.shared.objectContext {
                // Equivalent: NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                let p = Pokemon(context: context)
                p.entry_number = entryNumber
                p.name = name
                try? context.save()
            }
        }
    }
    
    class func findAll() -> [Pokemon]? {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            if let pokemons = try? context.fetch(request) {
                for p in pokemons {
                    print(p.name!)
                }
                return pokemons
            }
        }
        return nil
    }
    
    func findOne(byId: Int32) -> Pokemon? {
        
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            request.predicate = NSPredicate(format: "entry_number==%d", byId)
            if let pokemons = try? context.fetch(request) {
                return pokemons.first
            }
        } else {
            return self.pokedexCache[Int(byId)]
        }
        return nil
    }
    
}
