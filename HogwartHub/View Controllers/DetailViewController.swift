//
//  DetailViewController.swift
//  HogwartHub
//
//  Created by Tanya Burke on 10/27/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var characterImage: UIImageView!
        
        
          @IBOutlet weak var detailLabel: UILabel!
           
        @IBOutlet weak var backgroundImage: UIImageView!
        
        var character: Characters?
          
          override func viewDidLoad() {
              super.viewDidLoad()
            
             loadDetails()
            backgroundImage.loadGif(name: "clouds")
          }

          
          func loadDetails(){
              guard let character = character else{
                  fatalError("unable to access passed information")
              }
            navigationItem.title = "\(String(describing: character.name))"
            detailLabel.text = "Actor: \(character.actor)\nAncestry: \(character.ancestry)\nHouse: \(character.house)"
              
            
              

            characterImage.getImage(with: character.image) {[weak self] (result) in
                      switch result{
                      case .failure:
                          DispatchQueue.main.sync{
                              self?.characterImage.image = UIImage(systemName: "exclamationmark.triangle")

                          }
                      case .success(let image):
                          DispatchQueue.main.async {
                              self?.characterImage.image = image

                          }
                      }

                  }
              }
          
    }

