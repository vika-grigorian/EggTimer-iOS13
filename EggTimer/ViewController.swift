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
    
    let eggTime = ["Soft": 300, "Medium": 480, "Hard": 720] // перевели в секунды
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel! // аутлет для изменения заголовка
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() // отмена таймера после еще другого клика на кнопку
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed)/Float(totalTime))
        } else {
            // Остановим таймер сразу после завершения
            timer.invalidate() // Таймер останавливается
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
