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
}

