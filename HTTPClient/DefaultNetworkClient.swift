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
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let response = response as? HTTPURLResponse {
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
        }
        
        task.resume()
        
    }
    
    func post(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        
    }
    
    func put(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        
    }
    
}
