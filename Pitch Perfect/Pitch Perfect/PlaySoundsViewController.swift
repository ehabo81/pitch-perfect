//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ehab Issa on 3/10/15.
//  Copyright (c) 2015 Ehab Issa. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer : AVAudioPlayer!
    var recievedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000.0)
    }
    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
    }
    @IBAction func speedSoundButton(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudio(speed: 1.5)
    }

    @IBAction func slowSoundButton(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudio(speed: 0.5)
    }
    
    @IBAction func playDarvadarAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000.0)
    }
    func playAudio(#speed: Float)
    {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = speed
        audioPlayer.play()
    }
    
        func playAudioWithVariablePitch ( pitch :Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }

}
