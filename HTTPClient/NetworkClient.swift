//
//  NetworkClient.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

protocol NetworkClient {
    
    func get(url: String, headers: [String: String], params: [String: Any], callback: @escaping (HTTPResponse) -> Void)
    
    func put(url: String, headers: [String: String], params: Codable, contentType: ContentType, callback: @escaping (HTTPResponse) -> Void)
    
    func post<T>(url: String, headers: [String: String], params: T?, contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) where T: Codable
    
}
