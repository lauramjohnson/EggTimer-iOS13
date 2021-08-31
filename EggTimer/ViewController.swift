//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    let eggTimes = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        titleLabel.text = hardness
      
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(eggTimer), userInfo:nil, repeats: true)
        
    }
    
    @objc func eggTimer() {
        if secondsPassed < totalTime {

            secondsPassed += 1
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
        }
        progressBar.progress = Float(secondsPassed) / Float(totalTime)

    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
