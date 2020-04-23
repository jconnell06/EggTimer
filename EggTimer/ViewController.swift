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

    var player = AVAudioPlayer()
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        statusLabel.text = "How do you like your eggs?"
        progressBar.progress = 0.0
        stopButton.isEnabled = false
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        stopButton.isEnabled = true
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        statusLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            stopButton.isEnabled = false
            statusLabel.text = "Done."
            playSound()
            statusLabel.text = "How do you like your eggs?"
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}
