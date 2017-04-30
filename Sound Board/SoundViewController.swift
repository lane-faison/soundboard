//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Lane Faison on 4/30/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder? = nil // =nil isn't necessary. Swift will assume it without it
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
    }
    
    func setupRecorder() {
        do {
            // Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for the audio file
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basePath, "audio.m4a"]
            
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            print("################")
            print(audioURL)
            
            // Create settings for audio recorder
            
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // Create AudioRecorder object
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
            print(error) // This will print what the error is
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        
        if audioRecorder!.isRecording {
            
            // Stop the recording
            audioRecorder?.stop()
            
            // Change button title to Record
            recordButton.setTitle("Record", for: .normal)
            
        } else {
            // Start the recording
            audioRecorder?.record()
            
            // Change button title to Stop
            recordButton.setTitle("Stop", for: .normal)
        }
        
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
    }
    
}
