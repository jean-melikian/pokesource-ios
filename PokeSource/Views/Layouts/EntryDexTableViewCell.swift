//
//  DexTableViewCell.swift
//  PokéMine
//
//  Created by Jean-Christophe MELIKIAN on 22/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import UIKit

class EntryDexTableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
