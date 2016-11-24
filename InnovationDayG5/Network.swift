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
        case .GET: return "GET"
        case .DELETE: return "DELETE"
        case .POST: return "POST"
        case .PUT: return "PUT"
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
        let fullURL = baseURL + requestType.url
        
        let stringURL = fullURL.replacingOccurrences(of: " ", with: "%20")

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
}
