//
//  DefaultNetworkClient.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

import Foundation

class DefaultNetworkClient: NetworkClient {
 
    func get(url: String, params: [String : Any], callback: @escaping (HTTPResponse) -> Void) {
        
        guard let requestUrl = URL(string: "\(url)\(params.queryString())") else {
            print("Invalid url \(url)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            var responseData: [String: Any] = [:]
            
            if let data = data {
                do {
                    responseData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                } catch let error {
                    print(error)
                }
            }
            
            callback(HTTPResponse(statusCode: response.statusCode, headers: response.allHeaderFields, data: responseData))
            
        }
        
        task.resume()
        
    }
    
    func post(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        
    }
    
    func put(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        
    }
    
}
