//
//  ViewController.swift
//  SpeechRecognizerApp
//
//  Created by 清 貴幸 on 2016/06/21.
//  Copyright © 2016年 VOYAGE GROUP, Inc. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var recordButton: UIButton!
    
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(localeIdentifier: "ja-JP"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSpeechRecognizer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupSpeechRecognizer() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            OperationQueue.main().addOperation({
                switch authStatus {
                case .authorized:
                    self.textView.text = "authorized"
                    self.recordButton.isEnabled = true
                    
                case .denied:
                    self.textView.text = "denied"
                    self.recordButton.isEnabled = false
                    
                case .restricted:
                    self.textView.text = "restricted"
                    self.recordButton.isEnabled = false
                    
                case .notDetermined:
                    self.textView.text = "notDetermined"
                    self.recordButton.isEnabled = false
                }
            })
        }
    }
    
    @IBAction func didTouchUpRecordButton(_ sender: UIButton) {
        if audioEngine.isRunning {
            self.stopRecording()
        } else {
            try! self.startRecording()
        }
    }
    
    func startRecording() throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        if let recognitionTask = self.recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = self.recognitionRequest else {
            return
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        guard let inputNode = self.audioEngine.inputNode else {
            return
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        
        recognitionTask = self.speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            
            if let result = result {
                self.textView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        })
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try! audioEngine.start()
    }
    
    func stopRecording() {
        self.audioEngine.stop()
        recognitionRequest?.endAudio()
    }
}

