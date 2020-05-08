//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Emad Albarnawi on 07/05/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;
import AVFoundation;

class PlaySoundViewController: UIViewController {
    
    var recordedAudioURL: URL!;
    

    @IBOutlet weak var slowButton: UIButton!

    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        configureUI(.notPlaying);
        
        setUpScaleAspectForButtons()
        
    }
    
    func setUpScaleAspectForButtons(){
        slowButton.imageView?.contentMode = .scaleAspectFit;
        fastButton.imageView?.contentMode = .scaleAspectFit;
        highPitchButton.imageView?.contentMode = .scaleAspectFit;
        lowPitchButton.imageView?.contentMode = .scaleAspectFit;
        stopButton.imageView?.contentMode = .scaleAspectFit;
        reverbButton.imageView?.contentMode = .scaleAspectFit;
        echoButton.imageView?.contentMode = .scaleAspectFit;
    }
  
    @IBAction func playSoundForButton(_ sender: UIButton){
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }

        configureUI(.playing)
        
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        stopAudio();
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        setupAudio();
    }

}


