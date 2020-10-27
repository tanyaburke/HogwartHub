//
//  CharacterViewController.swift
//  HogwartHub
//
//  Created by Tanya Burke on 10/26/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import AVFoundation

class CharacterViewController: UIViewController {
    
@IBOutlet weak var tableView: UITableView!
    
    
    
    var audioPlayer: AVAudioPlayer?
    var characters = [Characters]() {
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadCharacters()
        startBackgroundMusic()
        
    }
    
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "Harry Potter Theme Song", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("can't segue")
        }
        detailVC.character = characters[indexPath.row]
        
    }
    
    private func loadCharacters(){
        HogwartsAPICLient.fetchCharacters(completion: {[weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Unable to load characters", message: "\(appError)")}
            case .success(let dataArray):
                self?.characters = dataArray
                dump(self!.characters)
            }
        })
        
    }
}



extension CharacterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        cell.imageView?.getImage(with: characters[indexPath.row].image, completion: { (result) in
            DispatchQueue.main.async{
                switch result{
                case .failure:
                    cell.imageView?.image = UIImage(named: "exclamationmark")
                case .success(let imageOk):
                    cell.imageView?.image = imageOk
                }
            }
        })
        return cell
    }
    
    
    
}
