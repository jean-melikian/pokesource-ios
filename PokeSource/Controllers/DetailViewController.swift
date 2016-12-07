//
//  DetailViewController.swift
//  PokeSource
//
//  Created by Jean-Christophe MELIKIAN on 07/12/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShareBarButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addShareBarButtonItem() {
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(DetailViewController.shareButtonPressed))
        
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    func shareButtonPressed() {
        //Do something now!
        print("Share button pressed !")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
