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
                    print("authorized")
                    
                case .denied:
                    print("denied")
                    
                case .restricted:
                    print("restricted")
                    
                case .notDetermined:
                    print("notDetermined")
                }
            })
        }
    }
}

