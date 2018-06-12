//
//  RxToDoManager.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Alamofire
import Argo

func addTodo(_ completion:@escaping (_ responseData: [RxToDo]?,
    _ error: Error?) -> Void) {
    let newRequest = RxToDoRequest(
        id: 1,
        name: "Saturday Grocery",
        description: "Bananas, Pineapple, Beer, Orange juice, ...",
        notes: "Check expiry date of orange juice",
        completed: false,
        synced: true
    )
    sendRequest(Urls.postTodo, request: newRequest) {
        (response, error) in
        if error == nil {
            let todos: [RxToDo]? = decode(response!)
            completion(todos, nil)
            print("request was successfull: \(todos)")
        } else {
            completion(nil, error)
            print("Error: \(error?.localizedDescription)")
        }
    }
}

func listTodos(_ completion:@escaping  (_ responseData: [RxToDo]?,
    _ error: Error?) -> Void) {
    sendRequest(Urls.getTodos, request: RequestModel()) {
        (response, error) in
        if error == nil {
            let todos: [RxToDo]? = decode(response!)
            completion(todos, nil)
            print("request was successfull: \(todos)")
        } else {
            completion(nil, error)
            print("Error: \(error?.localizedDescription)")
        }
    }
}

func addOrUpdateTodo(_ todo: [RxToDo]?,
                     completion:@escaping (_ responseData: [RxToDo]?,
    _ error: Error?) -> Void) {
    if let todoItem = todo?.first {
        let newRequest = TodoRequest(
            id: todoItem.id,
            name: todoItem.name,
            description: todoItem.description,
            notes: todoItem.notes!,
            completed: todoItem.completed,
            synced: true
        )
        sendRequest(Urls.postTodo, request: newRequest) {
            (response, error) in
            if error == nil {
                let todos: [Todo]? = decode(response!)
                let newTodo = todoSyncedLens.set(true, todoItem)
                store.dispatch(UpdateTodoAction(todo: newTodo))
                completion(todos, nil)
                print("request was successfull: \(todos)")
            } else {
                completion(nil, error)
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}

func updateTodo(_ todo: [RxToDo]?, completion:@escaping (
                _ responseData: [RxToDo]?, _ error: Error?) -> Void) {
    if let todoItem = todo?.first {
        let newRequest = RxToDoRequest(
            id: todoItem.id,
            name: todoItem.name,
            description: todoItem.description,
            notes: todoItem.notes!,
            completed: todoItem.completed,
            synced: true
        )
        sendRequest(Urls.update, request: newRequest) {
            (response, error) in
                if error == nil {
                    let todos: [RxToDo]? = decode(response!)
                    let newTodo = todoSyncedLens.set(true, todoItem)
                    store.dispatch(UpdateTodoAction(todo: newTodo))
                    completion(todos, nil)
                    print("request was successfull: \(todos)")
                } else {
                    completion(nil, error)
                    print("Error: \(error?.localizedDescription)")
                }
        }
    }
}
