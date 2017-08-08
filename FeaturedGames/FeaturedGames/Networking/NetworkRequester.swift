//
//  NetworkRequester.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 05/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

class NetworkRequester: NSObject, URLSessionDataDelegate, URLSessionTaskDelegate {
    
    private let url: URL?
    private let method: String?
    
    private var verbose: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    private let dispatchGroup = DispatchGroup()
    
    init(url: String, method: HTTPMethod) {
        self.url = URL(string: url)
        self.method = method.rawValue
    }
    
    private var request: NSMutableURLRequest? {
        guard let url = url, let method = method else {
            return nil
        }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method
        return request
    }
    
    private var headers: [String: String] {
        return ["Client-ID" : "uo6dggojyb8d6soh92zknwmi5ej1q2"]
    }
    
    func makeRequest(completion: @escaping (_ response: HTTPResponse) -> Void) {
        guard let request = request else {
            return
        }
        
        if verbose {
            debugPrint("# REQUEST")
            debugPrint("# URL: \(request.url?.absoluteString ?? "[invalid]")")
            debugPrint("# METHOD: \(request.httpMethod)")
            debugPrint("# HEADERS: \(headers)")
        }
        
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let queue = DispatchQueue(label: "\(String(describing: NetworkRequester.self).lowercased()).dispatchgroup",
                                  attributes: .concurrent, target: nil)
        
        dispatchGroup.enter()
        queue.async(group: dispatchGroup) {
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let response = response as? HTTPURLResponse, self.verbose {
                debugPrint("# RESPONSE")
                debugPrint("# STATUS: \(response.statusCode)")
                debugPrint("# DESCRIPTION: \(response.debugDescription)")
            }
            
            if let requestData = data {
                do {
                    let deserialized = try JSONSerialization.jsonObject(with: requestData, options: [])
                    if let json =  deserialized as? JSONDictionary {
                        completion(HTTPResponse(result: json, error: nil))
                    } else if let jsonArray = deserialized as? [JSONDictionary] {
                        completion(HTTPResponse(result: jsonArray, error: nil))
                    } else {
                        completion(HTTPResponse(result: [:], error: nil))
                    }
                } catch {
                    completion(HTTPResponse(result: [:], error: nil))
                }
                
            } else {
                completion(HTTPResponse(result: nil, error: .networkError))
            }
            session.finishTasksAndInvalidate()
        })
            task.resume()
            self.dispatchGroup.leave()
        }
    }
    
}
