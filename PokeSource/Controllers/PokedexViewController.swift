//
//  PokedexViewController.swift
//  PokeSource
//
//  Created by Jean-Christophe MELIKIAN on 16/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class PokedexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dexTableView: UITableView!
    
    private let cellIdentifier = "EntryDexTableViewCell"
    
    var jsonPokedex = [[String : AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokédex"
        self.dexTableView.rowHeight = 100
        self.dexTableView.dataSource = self
        self.dexTableView.delegate = self
        self.dexTableView.register(UINib.init(nibName: self.cellIdentifier, bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        
        
        // -- Beginning of /pokedex/2/ api call
        let uri = ApiManager.buildUri(route: "pokedex", targetNameOrId: "2")
        print(uri)
        
        Alamofire.request(uri).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Fetching data with success from \(uri)")
                if ((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    
                    if let resData = swiftyJsonVar["pokemon_entries"].arrayObject {
                        self.jsonPokedex = resData as! [[String:AnyObject]]
                        //print(self.jsonPokedex)
                        //print("Pokedex count: \(self.jsonPokedex.count)")
                        
                        if self.jsonPokedex.count > 0 {
                            for entry in self.jsonPokedex {
                                
                                if let pkmnNumber = entry["entry_number"] as? Int32 {
                                    if let pkmnName = entry["pokemon_species"]?["name"] as? String {
                                        PokemonDao.shared.upsertOne(entryNumber: pkmnNumber, name: pkmnName.capitalized)
                                    }
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Could't fetch data from \(uri)")
                print(error)
            }
            self.dexTableView.reloadData()
            
        }
        // -- End of /pokedex/2/ api call
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dexTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! EntryDexTableViewCell
        
        if let entry = PokemonDao.shared.findOne(byId: Int32(indexPath.row + 1)) {
            cell.numberLabel.text = "\(entry.entry_number)"
            
            if let pkmnImage:UIImage = UIImage(named: "\(entry.entry_number)") {
                cell.imageLabel.image = pkmnImage
            } else if let unknownImage:UIImage = UIImage(named:"0") {
                cell.imageLabel.image = unknownImage
            }
            cell.nameLabel.text = entry.name
            
        } else {
            cell.numberLabel.text = "\(indexPath.row + 1)"
            cell.nameLabel.text = "Unknown"
            if let pkmnImage:UIImage = UIImage(named: "\(indexPath.row + 1)") {
                cell.imageLabel.image = pkmnImage
            } else if let unknownImage:UIImage = UIImage(named:"0") {
                cell.imageLabel.image = unknownImage
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pokemonCount = PokemonDao.shared.pokedexCache.count
        print("Returning numberOfRowsInSection \(pokemonCount)")
        return pokemonCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.pokemonEntryNumber = PokemonDao.shared.pokedexCache[indexPath.row].entry_number
        detailVC.pokemonName = PokemonDao.shared.pokedexCache[indexPath.row].name!
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

