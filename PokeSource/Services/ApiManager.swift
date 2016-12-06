//
//  ApiManager.swift
//  PokéMine
//
//  Created by Jean-Christophe MELIKIAN on 18/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager {
    let baseUri:String = "http://pokeapi.co/api/v2"
    
    private init() {
        
    }
    
    func fetchPokedexEntries(pokedexId:Int) -> [[String : AnyObject]] {
        return apiRequest(route: String("/pokedex/\(pokedexId)"))
    }
    
    func apiRequest(route:String) -> [[String : AnyObject]] {
        // Array of dictionnary
        var arrayResponse = [[String : AnyObject]]()
        
        Alamofire.request(String(baseUri + route)).responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["pokemon_entries"].arrayObject {
                    arrayResponse = resData as! [[String:AnyObject]]
                }
            }
        }
        return arrayResponse

    }
}
