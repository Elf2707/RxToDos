//
//  Urls.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Alamofire

protocol RequestProtocol {
    subscript(key: String) -> (String?, String?) { get }
}

extension RequestProtocol {
    func getPropertyNames()-> [String] {
        return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
    }
}

struct RxToDoRequest: RequestProtocol {
    let id: Int
    let name: String
    let description: String
    let notes: String
    let completed: Bool
    let synced: Bool

    subscript(key: String) -> (String?, String?) {
        get {
            switch key {
            case "id": return (String(id), "id")
            case "name": return (name, "name")
            case "description": return (description, "description")
            case "notes": return (notes, "notes")
            case "completed": return (String(completed), "completed")
            case "synced": return (String(synced), "synced")
            default: return ("Cookie","test=123")
            }
        }
    }
}

func sendRequest(method: HTTPMethod, request: RequestProtocol) {
    let params = configureHeaders(request: request)
    Alamofire.request("http://localhost:8080/todos/", method: method, parameters: params, encoding: JSONEncoding.default, headers: nil)
        .validate()
        .responseJSON { response in
            if (response.result.error == nil) {
                debugPrint("HTTP Response Body: \(response.data)")
            } else {
                debugPrint("HTTP Request failed: \(response.result.error)")
            }
        }
}

func configureHeaders(request: RequestProtocol) -> [String: String] {
    let listOfProperties = request.getPropertyNames()
    var configuredRequestHeaders = Dictionary<String, String>()
    for property in listOfProperties {
        let (propertyValue, propertyName) = request[property]
        if propertyName != nil {
            configuredRequestHeaders[propertyName!] = propertyValue
        }
    }
    return configuredRequestHeaders
}
