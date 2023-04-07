//
//  ViewController.swift
//  eggTimer
//
//  Created by Can Kanbur on 7.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer?
    var eggTimer = ["Soft":3,"Medium":5,"Hard":7]
    var totalTime = 0
    var currentTime = 0
    var timer = Timer()
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }

    @IBAction func eggPressed(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimer[hardness]!
        progressBar.progress = 0.0
        currentTime = 0
        labelText.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(eggCalc), userInfo: nil, repeats: true)
        
        
        
    }
    @objc func eggCalc(){
    
        if currentTime < totalTime {
            currentTime += 1
            progressBar.progress = Float(currentTime) / Float(totalTime)
            labelText.text = String(totalTime - currentTime)
        }else{
            timer.invalidate()
            labelText.text = "Done"
            playSound()
        }
        
    }
    
    
    
    
    func playSound(){
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3") else {
            return
        }
        
        let url = URL(filePath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
}

