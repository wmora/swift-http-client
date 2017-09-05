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
    var headers = ["some": "header"]
    let callback = { (response: HTTPResponse) -> Void in
        
    }
    
    func testGet() {
        let testNetworkClient = TestNetworkClient()
        let httpClient = HTTPClient(networkClient: testNetworkClient)
        httpClient.baseURL = "https://example.com"
        httpClient.headers = headers
        httpClient.get(url: "/get", params: params, callback: callback)
        
        testNetworkClient.verify(method: "get", url: "https://example.com/get", headers: headers, params: params, contentType: nil, callback: callback)
    }
    
    func testPut() {
        let testNetworkClient = TestNetworkClient()
        let httpClient = HTTPClient(networkClient: testNetworkClient)
        httpClient.baseURL = "https://example.com"
        httpClient.headers = headers
        httpClient.put(url: "/put", params: params, callback: callback)
        
        headers["Content-Type"] = ContentType.json.rawValue
        testNetworkClient.verify(method: "put", url: "https://example.com/put", headers: headers, params: params, contentType: nil, callback: callback)
    }
    
    func testPost() {
        let testNetworkClient = TestNetworkClient()
        let httpClient = HTTPClient(networkClient: testNetworkClient)
        httpClient.baseURL = "https://example.com"
        httpClient.headers = headers
        httpClient.post(url: "/post", params: params, callback: callback)
        
        headers["Content-Type"] = ContentType.json.rawValue
        testNetworkClient.verify(method: "post", url: "https://example.com/post", headers: headers, params: params, contentType: ContentType.json, callback: callback)
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
    
    func get(url: String, headers: [String: String], params: [String : Any]?, callback: @escaping (HTTPResponse) -> Void) {
        recordInteraction(method: "get", url: url, headers: headers, params: params ?? [:], contentType: nil, callback: callback)
    }
    
    func put<T>(url: String, headers: [String : String], params: T, callback: @escaping (HTTPResponse) -> Void) where T: Codable {
        recordInteraction(method: "put", url: url, headers: headers, params: params, contentType: nil, callback: callback)
    }
    
    func post<T>(url: String, headers: [String : String], params: T?, contentType: ContentType, callback: @escaping (HTTPResponse) -> Void) where T : Decodable, T : Encodable {
        recordInteraction(method: "post", url: url, headers: headers, params: params ?? String(), contentType: contentType, callback: callback)
    }
    
    private func recordInteraction(method: String, url: String, headers: [String: String], params: Any, contentType: ContentType?, callback: @escaping (HTTPResponse) -> Void) {
        if var calls = interactions[method]?["calls"] as? [[String: Any]] {
            var call = [
                "url": url,
                "headers": headers,
                "params": params,
                "callback": callback
            ] as [String : Any]
            
            if let contentType = contentType {
                call["contentType"] = contentType
            }
            
            calls.append(call)
            interactions[method]?["calls"] = calls
        }
    }
    
    func verify(method: String, url: String, headers: [String: String], params: [String: Any], contentType: ContentType?, callback: @escaping (HTTPResponse) -> Void) {
        
        let calls: [[String: Any]] = interactions[method]?["calls"] as! [[String : Any]]
        let callObserver = calls.first!
        
        XCTAssertTrue(calls.count == 1)
        XCTAssertEqual(callObserver["url"] as? String, url)
        XCTAssertEqual(NSDictionary(dictionary: callObserver["params"] as! [String: Any]), NSDictionary(dictionary: params))
        XCTAssertEqual((callObserver["headers"] as? [String: String])!, headers)
        XCTAssertEqual(callObserver["contentType"] as? ContentType, contentType)
        XCTAssertNotNil(callObserver["callback"])
    }
    
}
