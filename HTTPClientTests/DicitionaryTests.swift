//
//  DicitionaryTests.swift
//  HTTPClient
//
//  Created by William Mora on 2017-08-26.
//  Copyright © 2017 William Mora. All rights reserved.
//

import XCTest
@testable import HTTPClient

class DicitionaryTests: XCTestCase {
    
    func testQueryString() {
        var params = ["a": "b"]
        XCTAssertEqual("?a=b", params.queryString())
        
        params["c"] = "d"
        XCTAssertEqual("?a=b&c=d", params.queryString())
        
        params.removeAll()
        XCTAssertEqual("", params.queryString())
    }
    
}
