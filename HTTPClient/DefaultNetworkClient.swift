//
//  DefaultNetworkClient.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

import Foundation

class DefaultNetworkClient: NetworkClient {
 
    func get(url: String, headers: [String: String], params: [String : Any]?, callback: @escaping (HTTPResponse) -> Void) {
        let requestParams = params ?? [:]
        guard let requestUrl = URL(string: "\(url)\(requestParams.queryString())") else {
            print("Invalid url \(url)")
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        executeTask(request: request, callback: callback)
    }
    
    func post<T>(url: String, headers: [String : String], params: T?, contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) where T : Codable {
        guard let requestUrl = URL(string: url) else {
            print("Invalid url \(url)")
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        if let params = params {
            do {
                request.httpBody = try JSONEncoder().encode(params)
            } catch let error {
                print("Params encoding failed: \(error). Ignoring call")
                return
            }
        }
        
        executeTask(request: request, callback: callback)
    }
    
    func put<T>(url: String, headers: [String: String], params: T, callback: @escaping (HTTPResponse) -> Void) where T : Codable {
        guard let requestUrl = URL(string: url) else {
            print("Invalid url \(url)")
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = headers
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch let error {
            print("Params encoding failed: \(error). Ignoring call")
            return
        }
        
        executeTask(request: request, callback: callback)
    }
    
    func executeTask(request: URLRequest, callback: @escaping (HTTPResponse) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            var responseData: Any?
            
            if let data = data {
                do {
                    responseData = try JSONSerialization.jsonObject(with: data)
                } catch let error {
                    print("Response data decoding failed: \(error)")
                }
            }
            
            callback(HTTPResponse(statusCode: response.statusCode, headers: response.allHeaderFields as! [String: String], data: responseData))
        }
        
        task.resume()
    }
    
}
