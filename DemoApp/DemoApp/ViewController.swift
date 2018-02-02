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
    @IBOutlet weak var responseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        httpClient.baseURL = "https://jsonplaceholder.typicode.com"
    }
    
    @IBAction func getButtonDidTouchUpInside(_ sender: UIButton) {
        httpClient.get(url: "/todos/1", params: [:], callback: { (response: HTTPResponse) in
            self.updateLabel(method: "GET", response: response)
        })
    }
    
    @IBAction func putButtonDidTouchUpInside(_ sender: Any) {
        let putObject = RequestObject(userId: 1, title: "Some todo item", completed: false)
        
        httpClient.put(url: "/todos/1", params: putObject, callback: { (response: HTTPResponse) in
            self.updateLabel(method: "PUT", response: response)
        })
    }

    @IBAction func postButtonDidTouchUpInside(_ sender: UIButton) {
        let postObject = RequestObject(userId: 1, title: "Some todo item", completed: true)
        
        httpClient.post(url: "/todos", params: postObject, callback: { (response: HTTPResponse) in
            self.updateLabel(method: "POST", response: response)
        })
    }
    
    func updateLabel(method: String, response: HTTPResponse) {
        DispatchQueue.main.async {
            self.responseLabel.text = "\(method) request complete:\nStatus code: \(response.statusCode)\nResponse data: \(response.data)"
        }
    }
    
}

class RequestObject: Codable {
    let userId: Int
    let title: String
    let completed: Bool
    
    init(userId: Int, title: String, completed: Bool) {
        self.userId = userId
        self.title = title
        self.completed = completed
    }
}
