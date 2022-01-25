//
//  ViewController.swift
//  EggTimer
//
//  Created by David Chester on 12/23/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: properties for timer and audio player
    var player = AVAudioPlayer()
    var timer = Timer()
    
    // labels
    var eggDone: UILabel!
    var timerLabel: UILabel!
    
    // progress bar
    var progressBar: UIProgressView!
    
    // views for our images and progress bar
    var topView = UIView()
    var eggImages = UIView()
    var progressView = UIView()
    
    //egg images
    var softEggBttn = UIButton()
    var softEggImg: UIImage!
    
    var medEggBttn = UIButton()
    var medEggImg: UIImage!
    
    var hardEggBttn = UIButton()
    var hardEggImg: UIImage!
    
    // Egg timmes
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    
    // timer variables we'll use in the eggTapped method
    var totalTime = 0
    var secondsPassed = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: eggTapped function
    
    @objc func eggTapped(_ sender: UIButton){
        
        // invalidate the timer to refresh
        timer.invalidate()
        // set the total countdown time based on the
        totalTime = eggTimes[sender.currentTitle!] ?? 0
        
        secondsPassed = 0
        progressBar.progress = 0
        
        eggDone.text = "Hardness: \(sender.currentTitle!)"
        
        timerLabel.isHidden = false
        progressBar.isHidden = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { Timer in
            // for as long as total time is not equal to 0 we run through this conditional
            if self.secondsPassed != self.totalTime  {
                //updating progress bar
                let percentageProgress = Float(self.secondsPassed) / Float(self.totalTime)
                self.progressBar.progress = Float(percentageProgress)
                // mintues and seconds to be passed into timerlabel
                let minutes = Int(self.totalTime - self.secondsPassed) / 60 % 60
                let seconds = Int(self.totalTime - self.secondsPassed) % 60
                // formatting mintues and seconds into timerlabel
                self.timerLabel.text = String(format:"%02i:%02i", minutes, seconds)
                self.secondsPassed += 1
            }
            else {
                Timer.invalidate()
                self.timerLabel.isHidden = true
                self.eggDone.text = "Done, enjoy your eggs"
                //alarm sound for when timer is finshed
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: ".mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player.play()
            }
        })
    }
}

// MARK: Load View extension
extension ViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .cyan.withAlphaComponent(0.9)
        
        
        // MARK: top view labels
        eggDone = UILabel()
        eggDone.translatesAutoresizingMaskIntoConstraints = false
        eggDone.text = "How do you like your Eggs?"
        eggDone.textAlignment = .center
        eggDone.font = UIFont.systemFont(ofSize: 22)
        eggDone.textColor = .darkGray
        topView.addSubview(eggDone)
        
        timerLabel = UILabel()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.isHidden = true
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 20)
        timerLabel.textColor = .darkGray
        topView.addSubview(timerLabel)
        
        // top view
        topView.translatesAutoresizingMaskIntoConstraints = false
        //   topView.backgroundColor = .yellow
        view.addSubview(topView)
        
        // MARK: egg image buttons
        softEggImg = UIImage(named: "soft_egg")
        softEggBttn = UIButton(type: .custom)
        softEggBttn.setTitle("Soft", for: .normal)
        softEggBttn.setBackgroundImage(softEggImg, for: .normal)
        softEggBttn.addTarget(self, action: #selector(eggTapped), for: .touchUpInside)
        softEggBttn.translatesAutoresizingMaskIntoConstraints = false
        // softEggBttn.contentMode = UIButton.ContentMode.scaleAspectFit
        eggImages.addSubview(softEggBttn)
        
        medEggImg = UIImage(named: "medium_egg")
        medEggBttn = UIButton(type: .custom)
        medEggBttn.setTitle("Medium", for: .normal)
        medEggBttn.setBackgroundImage(medEggImg, for: .normal)
        medEggBttn.addTarget(self, action: #selector(eggTapped), for: .touchUpInside)
        medEggBttn.translatesAutoresizingMaskIntoConstraints = false
        //medEggBttn.contentMode = UIButton.ContentMode.
        eggImages.addSubview(medEggBttn)
        
        hardEggImg = UIImage(named: "hard_egg")
        hardEggBttn = UIButton(type: .custom)
        hardEggBttn.setTitle("Hard", for: .normal)
        hardEggBttn.setBackgroundImage(hardEggImg, for: .normal)
        hardEggBttn.addTarget(self, action: #selector(eggTapped), for: .touchUpInside)
        hardEggBttn.translatesAutoresizingMaskIntoConstraints = false
        //hardEggBttn.contentMode = UIButton.ContentMode.scaleAspectFit
        eggImages.addSubview(hardEggBttn)
        
        // MARK: egg images view
        eggImages.translatesAutoresizingMaskIntoConstraints = false
        // eggImages.backgroundColor = .black
        view.addSubview(eggImages)
        
        
        // MARK: Progress Bar
        progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.progress = 0.5
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = .magenta
        progressBar.backgroundColor = .gray
        progressBar.isHidden = true
        progressView.addSubview(progressBar)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        //progressView.backgroundColor = .green
        view.addSubview(progressView)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            // top view and labels
            topView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            topView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),
            
            eggDone.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            eggDone.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: -30),
            eggDone.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.8),
            
            timerLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            
            
            // MARK: Egg images and view constraints
            eggImages.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30),
            eggImages.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            eggImages.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),
            eggImages.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
          
            softEggBttn.topAnchor.constraint(equalTo: eggImages.topAnchor, constant: 25),
            softEggBttn.bottomAnchor.constraint(equalTo: eggImages.bottomAnchor, constant: -70),
            softEggBttn.leadingAnchor.constraint(equalTo: eggImages.leadingAnchor, constant: 10),
         
            softEggBttn.widthAnchor.constraint(equalTo: eggImages.widthAnchor, multiplier: 0.29),
            
            medEggBttn.topAnchor.constraint(equalTo: softEggBttn.topAnchor),
            medEggBttn.bottomAnchor.constraint(equalTo: softEggBttn.bottomAnchor),
            medEggBttn.widthAnchor.constraint(equalTo: softEggBttn.widthAnchor),
            medEggBttn.centerXAnchor.constraint(equalTo: eggImages.centerXAnchor),
         
            
            hardEggBttn.topAnchor.constraint(equalTo: softEggBttn.topAnchor),
            hardEggBttn.bottomAnchor.constraint(equalTo: softEggBttn.bottomAnchor),
            hardEggBttn.widthAnchor.constraint(equalTo: softEggBttn.widthAnchor),
            hardEggBttn.trailingAnchor.constraint(equalTo: eggImages.trailingAnchor, constant: -10),
            
            // MARK: Progress constraints
            progressView.topAnchor.constraint(equalTo: eggImages.bottomAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.2),
            progressView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            progressBar.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            progressBar.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressBar.widthAnchor.constraint(equalTo: progressView.widthAnchor, multiplier: 0.7),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            
            
        ])
        
        
    }
}
