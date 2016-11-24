//
//  ViewController.swift
//  InnovationDayG5
//
//  Created by Carlo Donzelli on 24/11/16.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSpeech()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// IBActions
extension ViewController {
    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
        if viewModel.isAudioEngineRunning() {
            
            microphoneButton.isEnabled = false
            microphoneButton.setTitle("Start Recording", for: .normal)
        } else {
            viewModel.startRecording(handler: { (text) in
                self.textView.text = text
            })
            microphoneButton.setTitle("Stop Recording", for: .normal)
        }
    }
}


// private
private extension ViewController {

    func setupView() {
        microphoneButton.isEnabled = false
    }
    
    func setupSpeech() {
        viewModel.requestSpeechAuth { (isButtonEnabled) in
            self.microphoneButton.isEnabled = isButtonEnabled
        }
        
        viewModel.speechAvailableBlock = { isSpeechAvailable in
            self.microphoneButton.isEnabled = isSpeechAvailable
        }
    }
}

