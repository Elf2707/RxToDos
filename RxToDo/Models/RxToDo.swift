//
//  RxToDo.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Argo
import Curry
import Runes

enum RxToDoFilter: Int {
    case all
    case active
    case completed
    case notSyncedWithBackend
    case selected
}

struct RxToDo {
    let id: Int
    let name: String
    let description: String
    let notes: String?
    let completed: Bool
    let synced: Bool
    let selected: Bool?
}

extension RxToDo: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<RxToDo> {
        return curry(RxToDo.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <| "description"
            <*> json <|? "notes"
            <*> json <| "completed"
            <*> json <| "synced"
            <*> json <|? "selected"
    }
}

extension RxToDo: Equatable {}

func == (lhs: RxToDo, rhs: RxToDo) -> Bool {
    return lhs.id == rhs.id
}
