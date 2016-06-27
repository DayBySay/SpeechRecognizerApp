//
//  FRecognizeFromFileViewController.swift
//  SpeechRecognizerApp
//
//  Created by 清 貴幸 on 2016/06/22.
//  Copyright © 2016年 VOYAGE GROUP, Inc. All rights reserved.
//

import UIKit
import Speech

class FRecognizeFromFileViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func touchUpDanseiButton(_ sender: AnyObject) {
        self.textView.text = ""
        
        let path = Bundle.main().pathForResource("Dansei", ofType: "mp3")!
        let audioFileURL = URL(fileURLWithPath: path)
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: audioFileURL)
        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            print (result?.bestTranscription.formattedString)
            self.textView.text = result?.bestTranscription.formattedString
        })
    }
    
    @IBAction func touchUpJoseiButton(_ sender: AnyObject) {
        self.textView.text = ""
        
        let path = Bundle.main().pathForResource("Josei", ofType: "mp3")!
        let audioFileURL = URL(fileURLWithPath: path)
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: audioFileURL)
        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            print (result?.bestTranscription.formattedString)
            self.textView.text = result?.bestTranscription.formattedString
        })
    }
    
    
    @IBAction func touchUpBosanButton(_ sender: UIButton) {
        self.textView.text = ""
        
        let path = Bundle.main().pathForResource("Bosan", ofType: "mp3")!
        let audioFileURL = URL(fileURLWithPath: path)
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: audioFileURL)
        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            print (result?.bestTranscription.formattedString)
            self.textView.text = result?.bestTranscription.formattedString
        })
    }
}
