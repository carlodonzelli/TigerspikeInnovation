//
//  ViewModel.swift
//  InnovationDayG5
//
//  Created by Carlo Donzelli on 24/11/16.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import Foundation
import Speech

class HomeViewModel: NSObject {
    
    var speechAvailableBlock: ((Bool) -> Void)?
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-AU"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    func ViewModel() {
        speechRecognizer.delegate = self
    }
    
    func requestSpeechAuth(handler: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                handler(isButtonEnabled)
            }
        }
    }
    
    func isAudioEngineRunning() -> Bool {
        return audioEngine.isRunning
    }
    
    func stopAudioEngine() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
   
    
    func startRecording(handler: @escaping (String?) -> Void) {
        
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true  //6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                
                handler(result?.bestTranscription.formattedString)  //9
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                //self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        handler("")
    }
    
    func sendRequest(text: String, handler: @escaping (Bool) -> Void) {
        
        let eventType = eventTypeForString(text: text)
        
        Network.eventRequest(httpMethod: .POST, requestType: eventType, completionHandler: handler)
    }
    
    func eventTypeForString(text: String) -> RequestType {
        if text.lowercased().hasPrefix("extend") {
            
            let (meetingName, numberOfMinutes) = extractExtendEventInfo(text: text)
            
            return .ExtendEvent(meetingName, numberOfMinutes)
            
        } else {
            return .CreateEvent(text)
        }
    }
    
    func extractExtendEventInfo(text: String) -> (meetingName: String, numberOfMinutes: String) {
        let meetingNameStartIndex = text.index(text.startIndex, offsetBy: 7)
        
        let rangeOfFor = text.range(of: "for")
        
        let startIndexOfFor = rangeOfFor!.lowerBound
        
        let rangeOfMeetingName = meetingNameStartIndex..<startIndexOfFor
        let meetingName = text.substring(with: rangeOfMeetingName).trimmingCharacters(in: .whitespacesAndNewlines)
        
        let rangeOfMinutes = text.range(of: "minute")
        
        let endIndexOfFor = rangeOfFor!.upperBound
        let startIndexOfMinutes = rangeOfMinutes!.lowerBound
        
        let rangeOfNumeralMinutes = endIndexOfFor..<startIndexOfMinutes
        let numberOfMinutes = text.substring(with: rangeOfNumeralMinutes).trimmingCharacters(in: .whitespacesAndNewlines)
        
        return (meetingName: meetingName, numberOfMinutes: numberOfMinutes)
    }
    
}

extension HomeViewModel: SFSpeechRecognizerDelegate {
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        speechAvailableBlock?(available)
    }
}
