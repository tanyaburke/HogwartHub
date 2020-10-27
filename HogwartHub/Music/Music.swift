//
//  Music.swift
//  Ghibli Hub
//
//  Created by Tanya Burke on 1/8/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class MusicPlayer: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        startBackgroundMusic()
    }
    
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    
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
}
