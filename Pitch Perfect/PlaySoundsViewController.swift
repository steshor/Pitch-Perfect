//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stephen Short on 24/05/2015.
//  Copyright (c) 2015 Stephen Short. All rights reserved.
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
//        if var filepath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var fileUrl = NSURL.fileURLWithPath(filepath)
//
//        }else{
//            println("the file is missing")
//        }
        
        audioEngine = AVAudioEngine()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlow(sender: UIButton) {
        playAtRate(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAtRate(1.5)
    }
    
    func playAtRate (speed: Float){
        audioPlayer.stop()
        audioPlayer.rate = speed;
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func stopPlay(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch:Float){
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to:changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
