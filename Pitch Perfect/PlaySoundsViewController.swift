//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stephen Short on 08/02/2016.
//  Copyright © 2016 Stephen Short. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!


    override func viewDidLoad() {
        super.viewDidLoad()
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            let filePathURL = NSURL.fileURLWithPath(filePath)
//            
//        }else{
//            print("filepath empty")
//        }
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
        audioPlayer.enableRate = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudio(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    
    func playAudioWithVariablePitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()

    }
    
    func playAudio(speed: Float){
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }



}
