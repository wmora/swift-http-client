//
//  Dictionary.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-26.
//  Copyright © 2017 William Mora. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func queryString() -> String {
        guard !isEmpty else {
            return ""
        }
        
        var queryString = "?"
        
        for (key, value) in self {
            let prefix = queryString.count == 1 ? "" : "&"
            queryString = "\(queryString)\(prefix)\(key)=\(value)"
        }
        
        return queryString
    }
    
}
