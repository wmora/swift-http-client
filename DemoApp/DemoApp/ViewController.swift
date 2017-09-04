//
//  ViewController.swift
//  DemoApp
//
//  Created by William Mora on 2017-09-03.
//  Copyright © 2017 William Mora. All rights reserved.
//

import UIKit
import HTTPClient

class ViewController: UIViewController {

    let httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        httpClient.baseURL = "https://jsonplaceholder.typicode.com"
    }
    
    @IBAction func getButtonDidTouchUpInside(_ sender: UIButton) {
        httpClient.get(url: "/todos/1", params: [:], callback: { (response: HTTPResponse) in
            print("GET request complete:")
            print("\(response.statusCode)")
            print("\(response.headers)")
            print("\(response.data)")
        })
    }

    @IBAction func postButtonDidTouchUpInside(_ sender: UIButton) {
        let postObject = PostObject(userId: 1, title: "Some todo item", completed: true)
        
        httpClient.post(url: "/todos", params: postObject) { (response: HTTPResponse) in
            print("POST request complete:")
            print("\(response.statusCode)")
            print("\(response.headers)")
            print("\(response.data)")
        }
    }
    
}

class PostObject: Codable {
    let userId: Int
    let title: String
    let completed: Bool
    
    init(userId: Int, title: String, completed: Bool) {
        self.userId = userId
        self.title = title
        self.completed = completed
    }
}
