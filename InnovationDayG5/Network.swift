//
//  Network.swift
//  InnovationDayG5
//
//  Created by Carlo Donzelli on 24/11/16.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

enum HTTPMethod {
    
    case GET
    case DELETE
    case POST
    case PUT
    
    var description: String {
        
        switch self {
        case .GET:
            return "GET"
        case .DELETE:
            return "DELETE"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        }
    }
}

enum RequestType {
    
    case CreateEvent(String)
    case ExtendEvent(String, String)
    
    var url: String {
        switch self {
        case .CreateEvent(let meetingSchedule):
            return "/createevent?eventstring=\(meetingSchedule)"
        case .ExtendEvent(let meetingname, let minutes):
            return "/createevent?meetingname=\(meetingname)&timeinMinutes=\(minutes)"
        }
    }
}



struct Network {
    
    static func eventRequest(httpMethod: HTTPMethod, requestType: RequestType, completionHandler: @escaping (Bool) -> Void) {
        
        let baseURL = "http://vinh-pc.infra.tigerspike.com/Team5InnovationDay/api/calendar"
        
        let stringURL = requestType.url.replacingOccurrences(of: " ", with: "%20")

        var request = URLRequest(url: URL(string: "\(baseURL)\(stringURL)")!)
        request.httpMethod = httpMethod.description
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                completionHandler(false)
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            completionHandler(true)
        }
        task.resume()
    }
    
    
    static func toggleLight(httpMethod: HTTPMethod, completionHandler: @escaping (Bool) -> Void) {
        
        let baseURL = "https://api.lifx.com/v1/lights/all/toggle"
        var request = URLRequest(url: URL(string: baseURL)!)
        request.setValue("Bearer ccec456516356aa920e9f31a4d0f8b19782711c62d29892dc6e04c7525c1cb62", forHTTPHeaderField: "Authorization")
        request.httpMethod = httpMethod.description
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Networ error = \(error)")
                return
            }
        
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 207 {
                print("statusCode should be 207, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                completionHandler(false)
            }
            
            if let JSONresponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print("response = \(JSONresponse)")
                completionHandler(true)
            }
        }
        task.resume()
    }
}
