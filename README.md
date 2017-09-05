[![Build Status](https://travis-ci.org/wmora/swift-http-client.svg?branch=master)](https://travis-ci.org/wmora/swift-http-client)

# HTTP Client

A (very) basic HTTP client for JSON requests.

# Usage

```swift
let httpClient = HTTPClient()

httpClient.baseURL = "https://example.com"
httpClient.headers = ["Authorization": "Bearer someToken"]

httpClient.get(url: "/foo/1", params: ["a":"b"], callback: { (response: HTTPResponse) in
    print("GET request complete:")
    print("\(response.statusCode)")
    print("\(response.headers)")
    print("\(response.data)")
})

httpClient.put(url: "/foo/1", params: MyCodableObject(), callback: { (response: HTTPResponse) in
    print("PUT request complete:")
    print("\(response.statusCode)")
    print("\(response.headers)")
    print("\(response.data)")
})

httpClient.post(url: "/foo", params: MyCodableObject(), callback: { (response: HTTPResponse) in
    print("POST request complete:")
    print("\(response.statusCode)")
    print("\(response.headers)")
    print("\(response.data)")
})
```
