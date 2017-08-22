//
//  HTTPResponse.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

class HTTPResponse {
    
    var statusCode: Int
    var headers: [AnyHashable: Any]
    var data: [String: Any]
    
    init(statusCode: Int, headers: [AnyHashable: Any], data: [String: Any]) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }
    
}
