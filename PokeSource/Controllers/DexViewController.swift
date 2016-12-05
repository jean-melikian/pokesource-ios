//
//  ViewController.swift
//  PokéMine
//
//  Created by Jean-Christophe MELIKIAN on 16/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import UIKit
import CoreData

class DexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dexTableView: UITableView!
    
    private let cellIdentifier = "EntryDexTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dexTableView.rowHeight = 100
        self.dexTableView.dataSource = self
        self.dexTableView.delegate = self
        self.dexTableView.register(UINib.init(nibName: self.cellIdentifier, bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dexTableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! EntryDexTableViewCell
        
        cell.numberLabel.text = "\(indexPath.item + 1)"
        cell.nameLabel.text = "Bulbizarre"
        
        if let pkmnImage:UIImage = UIImage(named: "\(indexPath.item + 1)") {
            print("Successfuly fetched image")
            cell.imageLabel.image = pkmnImage
        } else if let unknownImage:UIImage = UIImage(named:"0") {
            cell.imageLabel.image = unknownImage
            print("Couldn't fetch image")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 151
    }
    
    
}

