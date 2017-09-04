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
    }

    @IBAction func getButtonDidTouchUpInside(_ sender: UIButton) {
        httpClient.get(url: "https://jsonplaceholder.typicode.com/posts/1", params: [:], callback: { (response: HTTPResponse) in
            print("\(response.statusCode)")
            print("\(response.headers)")
            print("\(response.data)")
        })
    }

}

