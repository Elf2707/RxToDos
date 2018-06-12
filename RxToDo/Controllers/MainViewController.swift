//
//  ViewController.swift
//  RxToDo
//
//  Created by Elf on 11.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import UIKit
import Argo

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let newRequest = RxToDoRequest(
            id: 1,
            name: "First request",
            description: "description",
            notes: "notess",
            completed: false,
            synced: false
        )
        sendRequest(.postTodo, request: newRequest) {
            (response, error) in
            if error == nil {
                let todos: [RxToDo]? = decode(response!)
                print("request was successfull: \(todos)")
            } else {
                print("Error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
