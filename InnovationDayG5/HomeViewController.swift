//
//  HomeViewController.swift
//  InnovationDayG5
//
//  Created by Carlo Donzelli on 24/11/16.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var lightBulbButton: UIButton!
    
    let viewModel = HomeViewModel()
    var userText: String?
    
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
extension HomeViewController {
    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
        if viewModel.isAudioEngineRunning() {
        
            microphoneButton.isEnabled = false
            microphoneButton.setTitle("🎙", for: .normal)
            
            if let eventText = userText {

                viewModel.sendCalendarRequest(text: eventText, handler: { (isEventCreated) in
                    if isEventCreated {
                        self.showError(with: "Success", message: "Event created or extended")
                        self.microphoneButton.isEnabled = true
                        self.viewModel.stopAudioEngine()
                    } else {
                        self.showError(message: "Request failed")
                    }
                })
            } else {
                self.showError(message: "Nothing was said")
            }
        } else {
            
            viewModel.startRecording(handler: { (text) in
                
                self.textView.text = text
                self.userText = text
            })
            microphoneButton.setTitle("🎶", for: .normal)
        }
    }
    
    @IBAction func lightBulbTapped(_ sender: AnyObject) {
        if viewModel.areLightsOn() {
            lightBulbButton.setTitle("🌑", for: .normal)
        } else {
            lightBulbButton.setTitle("🌕", for: .normal)
        }
        viewModel.toggleLight()

    }
}


// private
private extension HomeViewController {
    
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
