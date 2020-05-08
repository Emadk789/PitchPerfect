//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Emad Albarnawi on 07/05/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit
import AVFoundation;

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
// MARK: These are outlet
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        stopRecordButton.isEnabled = false;
    }
// MARK: Start recording
    @IBAction func recordAudio(_ sender: Any) {
        print("Record button was pressed!!!");
        recordingLabel.text = "Recording in progress!";
        switchState(of: recordButton);
        switchState(of: stopRecordButton);
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        print("This is the path:");
        print(filePath ?? "There is no path");

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:]);
        audioRecorder.delegate = self;
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    // MARK: Stop recording
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop recording button was pressed!!");
        recordingLabel.text = "Recording is NOT in progress!";
        switchState(of: recordButton);
        switchState(of: stopRecordButton);
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    // MARK: Switch the state of the record and stop buttons.
    func switchState(of x: UIButton){
        x.isEnabled = !x.isEnabled;
    }
    // MARK: Called when the audio finishes recording
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not succesful!");
        }
    }
    // MARK: prepare the next screen when the segue is called
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC = segue.destination as! PlaySoundViewController;
            let recordedAudioURL = sender as! URL;
            playSoundsVC.recordedAudioURL = recordedAudioURL;
        }
    }
}

