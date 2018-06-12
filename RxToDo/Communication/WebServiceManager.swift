//
//  WebServiceManager.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

//
//  Urls.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Alamofire


func sendRequest(
    _ url: Urls,
    request: RequestProtocol,
    completion: @escaping (_ data: AnyObject?, _ err: AnyObject?) -> Void
) {
    let params = configureParams(request: request)
    let (method, url) = url.httpMethodUrl()

    Alamofire.request("http://localhost:8080/todos/", method: method, parameters: params, encoding: JSONEncoding.default, headers: nil)
        .validate()
        .responseJSON { response in
            if (response.result.error == nil) {
                debugPrint("HTTP Response Body: \(response.data)")
                completion(response.result.value as AnyObject, nil)
            } else {
                debugPrint("HTTP Request failed: \(response.result.error)")
                completion(nil, response.result.error as AnyObject)
            }
    }
}

func configureParams(request: RequestProtocol) -> [String: String] {
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
