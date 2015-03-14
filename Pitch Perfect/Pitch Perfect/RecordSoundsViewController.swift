//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ehab Issa on 3/8/15.
//  Copyright (c) 2015 Ehab Issa. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {
    var audioRecorder : AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordAudioButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordAudioButton.enabled = true
        recordingLabel.text = "Tap to Record"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func recordAudio(sender: UIButton) {
        println("recordinAudio")
        recordingLabel.text = "Recording"
        stopButton.hidden = false
        recordAudioButton.enabled = false
        //TODO:Recod the Audio File
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) [0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath,recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self

        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopSague"
        {
            let PlaySoundsVC : PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            PlaySoundsVC.recievedAudio = data
        }
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            
        
                recordedAudio = RecordedAudio(filePath: recorder.url, fileTitle: recorder.url.lastPathComponent!)

                self.performSegueWithIdentifier("stopSague", sender: recordedAudio)
                }
        else
                {
                println("SOmething Happened")
                recordAudioButton.enabled = true
                stopButton.hidden = true
                }
        
    }
    @IBAction func stopButton(sender: UIButton) {
        recordingLabel.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
            }
}

