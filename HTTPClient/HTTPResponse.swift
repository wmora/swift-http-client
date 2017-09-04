//
//  HTTPResponse.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

public class HTTPResponse {
    
    public let statusCode: Int
    public let headers: [String: String]
    public let data: [String: Any]
    
    init(statusCode: Int, headers: [String: String], data: [String: Any]?) {
        self.statusCode = statusCode
        self.headers = headers
        if let data = data {
            self.data = data
        } else {
            self.data = [:]
        }
    }
    
    public func isSuccessful() -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
}
