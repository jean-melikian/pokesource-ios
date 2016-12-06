//
//  ApiManager.swift
//  PokéMine
//
//  Created by Jean-Christophe MELIKIAN on 18/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import Foundation

class Api {
    static let baseUri:String = String("http://pokeapi.co/api/v2")
    
    static func buildUri(route:String, targetNameOrId: String?) -> String {
        if let target = targetNameOrId {
            return baseUri + String("/\(route)/\(target)/")
        } else {
            return baseUri + String("/\(route)/")
        }
    }
}
