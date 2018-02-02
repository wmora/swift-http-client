//
//  HTTPResponse.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

import Foundation

@objc
public class HTTPResponse: NSObject {
    
    @objc public let statusCode: Int
    @objc public let headers: [String: String]
    @objc public let data: Any
    
    init(statusCode: Int, headers: [String: String], data: Any?) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data ?? [:]
    }
    
    public func isSuccessful() -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
}
