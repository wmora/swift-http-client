//
//  HTTPResponseTests.swift
//  HTTPClientTests
//
//  Created by William Mora on 2017-09-04.
//  Copyright © 2017 William Mora. All rights reserved.
//

import XCTest
@testable import HTTPClient

class HTTPResponseTests: XCTestCase {
    
    func testIsSuccessful() {
        for successfulStatusCode in 200...299 {
            XCTAssertTrue(checkStatusCode(statusCode: successfulStatusCode))
        }
        
        for errorStatusCode in 300...599 {
            XCTAssertFalse(checkStatusCode(statusCode: errorStatusCode))
        }
    }
    
    func checkStatusCode(statusCode: Int) -> Bool {
        let response = HTTPResponse(statusCode: statusCode, headers: [:], data: nil)
        return response.isSuccessful()
    }
    
}
