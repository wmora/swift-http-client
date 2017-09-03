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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let httpClient = HTTPClient()
        print(httpClient)
        httpClient.get(url: "https://jsonplaceholder.typicode.com/posts/1", params: [:], callback: { (response: HTTPResponse) in
            print("\(response.statusCode)")
            print("\(response.headers)")
            print("\(response.data)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

