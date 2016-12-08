//
//  DetailViewController.swift
//  PokeSource
//
//  Created by Jean-Christophe MELIKIAN on 07/12/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainPokemonImage: UIImageView!
    var pokemonEntryNumber : Int32 = 0
    var pokemonName : String = "Unknown"
    var image = UIImage(named: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        
        addShareBarButtonItem()
        self.title = pokemonName
        if let mainImage = UIImage(named: "\(pokemonEntryNumber)") {
            mainPokemonImage.image = mainImage
            image = mainImage
        } else {
            mainPokemonImage.image = UIImage(named: "0")
        }
        
        // -- Beginning of /pokemon/id/ api call
        let uri = ApiManager.buildUri(route: "pokemon", targetNameOrId: "\(pokemonEntryNumber)")
        print(uri)
        Alamofire.request(uri).responseJSON { response in
            switch response.result {
            case .success:
                if ((response.result.value) != nil) {
                    let pokemonObj = JSON(response.result.value!)
                    
                    if let types = pokemonObj["types"].arrayObject {
                        print(types)
                        // TODO: Store types and display them
                    }
                }
                
            case .failure(let error):
                print("Could't fetch data from \(uri)")
                print(error)
            }
        }
        // -- End of /pokemon/2/ api call
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
        print("Share button pressed !")
        let string = "My favorite Pokémon is \(pokemonName) !"
        let activityViewController = UIActivityViewController(activityItems: [string, image!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.print,
                                                        UIActivityType.copyToPasteboard,
                                                        UIActivityType.assignToContact,
                                                        UIActivityType.saveToCameraRoll,
                                                        UIActivityType.addToReadingList,
                                                        UIActivityType.airDrop,
                                                        UIActivityType.message,
                                                        UIActivityType.postToFlickr,
                                                        UIActivityType.postToVimeo,
                                                        UIActivityType.postToTencentWeibo,
                                                        UIActivityType.postToWeibo,
        ]
        navigationController?.present(activityViewController, animated: true) {
            
        }
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
