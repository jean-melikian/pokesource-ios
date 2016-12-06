//
//  ViewController.swift
//  PokéMine
//
//  Created by Jean-Christophe MELIKIAN on 16/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class DexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dexTableView: UITableView!
    
    private let cellIdentifier = "EntryDexTableViewCell"
    
    var pokedexEntries = [[String : AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dexTableView.rowHeight = 100
        self.dexTableView.dataSource = self
        self.dexTableView.delegate = self
        self.dexTableView.register(UINib.init(nibName: self.cellIdentifier, bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        
        
        let uri = Api.buildUri(route: "pokedex", targetNameOrId: "2")
        print(uri)
        Alamofire.request(uri).responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["pokemon_entries"].arrayObject {
                    self.pokedexEntries = resData as! [[String:AnyObject]]
                    print(self.pokedexEntries)
                    print("Pokedex count: \(self.pokedexEntries.count)")

                }
                if self.pokedexEntries.count > 0 {
                    self.dexTableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dexTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! EntryDexTableViewCell
        
        let row = indexPath.row
        var entry = self.pokedexEntries[row]
        
        if let pkmnNumber = entry["entry_number"]?.int32Value {
            cell.numberLabel.text = "\(pkmnNumber)"
            
            if let pkmnImage:UIImage = UIImage(named: "\(pkmnNumber)") {
                cell.imageLabel.image = pkmnImage
            }
        } else if let unknownImage:UIImage = UIImage(named:"0") {
            cell.imageLabel.image = unknownImage
        }
        
        if let pkmnName = entry["pokemon_species"]?["name"] {
            cell.nameLabel.text = pkmnName as! String?
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexEntries.count
    }
    
    
}

