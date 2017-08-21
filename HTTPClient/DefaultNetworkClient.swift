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
            
        }
        
        task.resume()
        
    }
    
    func post(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        
    }
    
    func put(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        
    }
    
}
