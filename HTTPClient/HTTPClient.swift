//
//  HTTPClient.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

import Foundation

public class HTTPClient {
    
    var baseURL: String = ""
    var headers: [String: String] = [:]
    let networkClient: NetworkClient
    
    public convenience init() {
        self.init(networkClient: DefaultNetworkClient())
    }
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    public func get(url: String, params: [String: Any]?, callback: @escaping (HTTPResponse) -> Void = {_ in }) {
        networkClient.get(url: fullURL(url: url), headers: headers, params: params, callback: callback)
    }
    
    func put(url: String, params: [String: Any], callback: @escaping (HTTPResponse) -> Void = {_ in }) {
        networkClient.put(url: fullURL(url: url), headers: headers, params: params, contentType: ContentType.json, callback: callback)
    }
    
    func post(url: String, params: [String: Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void = {_ in }) {
        networkClient.post(url: fullURL(url: url), headers: headers, params: params, contentType: contentType, callback: callback)
    }
    
    func fullURL(url: String) -> String {
        return "\(baseURL)\(url)"
    }
    
}
