//
//  HTTPClientTests.swift
//  HTTPClientTests
//
//  Created by William Mora on 2017-08-20.
//  Copyright © 2017 William Mora. All rights reserved.
//

import XCTest
@testable import HTTPClient

class HTTPClientTests: XCTestCase {
    
    let params = ["a": "b"]
    let callback = { (response: HTTPResponse) -> Void in
        
    }
    
    func testGet() {
        let testNetworkClient = TestNetworkClient()
        let httpClient = HTTPClient(networkClient: testNetworkClient)
        httpClient.baseURL = "https://example.com"
        httpClient.get(url: "/get", params: params, callback: callback)
        
        testNetworkClient.verify(method: "get", url: "https://example.com/get", params: params, contentType: ContentType.json, callback: callback)
    }
    
    func testPut() {
        let testNetworkClient = TestNetworkClient()
        let httpClient = HTTPClient(networkClient: testNetworkClient)
        httpClient.baseURL = "https://example.com"
        httpClient.put(url: "/put", params: params, callback: callback)
        
        testNetworkClient.verify(method: "put", url: "https://example.com/put", params: params, contentType: ContentType.json, callback: callback)
    }
    
    func testPost() {
        let testNetworkClient = TestNetworkClient()
        let httpClient = HTTPClient(networkClient: testNetworkClient)
        httpClient.baseURL = "https://example.com"
        httpClient.post(url: "/post", params: params, contentType: ContentType.json, callback: callback)
        
        testNetworkClient.verify(method: "post", url: "https://example.com/post", params: params, contentType: ContentType.json, callback: callback)
    }
    
}

class TestNetworkClient: NetworkClient {
    
    var interactions = [
        "get": [
            "calls": []
        ],
        "put": [
            "calls": []
        ],
        "post": [
            "calls": []
        ]
    ]
    
    func get(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        recordInteraction(method: "get", url: url, params: params, contentType: contentType, callback: callback)
    }
    
    func put(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        recordInteraction(method: "put", url: url, params: params, contentType: contentType, callback: callback)
    }
    
    func post(url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        recordInteraction(method: "post", url: url, params: params, contentType: contentType, callback: callback)
    }
    
    private func recordInteraction(method: String, url: String, params: [String : Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        if var calls = interactions[method]?["calls"] as? [[String: Any]] {
            calls.append([
                "url": url,
                "params": params,
                "contentType": contentType,
                "callback": callback
                ])
            interactions[method]?["calls"] = calls
        }
    }
    
    func verify(method: String, url: String, params: [String: Any], contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) {
        
        let calls: [[String: Any]] = interactions[method]?["calls"] as! [[String : Any]]
        let callObserver = calls.first!
        
        XCTAssertTrue(calls.count == 1)
        XCTAssertEqual(callObserver["url"] as? String, url)
        XCTAssertEqual(NSDictionary(dictionary: callObserver["params"] as! [String: Any]), NSDictionary(dictionary: params))
        XCTAssertEqual(callObserver["contentType"] as? ContentType, contentType)
        XCTAssertNotNil(callObserver["callback"])
    }
    
}
