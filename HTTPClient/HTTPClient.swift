//
//  HTTPClient.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

import Foundation

@objc
public class HTTPClient : NSObject {
    
    @objc public var baseURL: String = ""
    public var headers: [String: String] = [:]
    let networkClient: NetworkClient
    
    public convenience override init() {
        self.init(networkClient: DefaultNetworkClient())
    }
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    @objc public func get(url: String, params: [String: Any], callback: @escaping (HTTPResponse) -> Void = {_ in }) {
        networkClient.get(url: fullURL(url: url), headers: headers, params: params, callback: callback)
    }
    
    public func put<T>(url: String, params: T, callback: @escaping (HTTPResponse) -> Void = {_ in }) where T: Codable {
        headers["Content-Type"] = ContentType.json.rawValue
        networkClient.put(url: fullURL(url: url), headers: headers, params: params, callback: callback)
    }
    
    public func post<T>(url: String, params: T?, callback: @escaping (HTTPResponse) -> Void = {_ in }) where T: Codable {
        post(url: url, params: params, contentType: ContentType.json, callback: callback)
    }
    
    func post<T>(url: String, params: T?, contentType: ContentType = ContentType.json, callback: @escaping (HTTPResponse) -> Void = {_ in }) where T: Codable {
        headers["Content-Type"] = contentType.rawValue
        networkClient.post(url: fullURL(url: url), headers: headers, params: params, contentType: contentType, callback: callback)
    }
    
    func fullURL(url: String) -> String {
        return "\(baseURL)\(url)"
    }
    
}
