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

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

let todoNameLens: Lens<RxToDo, String> = Lens(
    get: { $0.name},
    set: {
        RxToDo(
            id: $1.id,
            name: $0,
            description: $1.description,
            notes: $1.notes,
            completed: $1.completed,
            synced: $1.synced,
            selected: $1.selected
        )
    }
)

let todoDescriptionLens: Lens<RxToDo, String> = Lens(
    get: { $0.description},
    set: {
        RxToDo(
            id: $1.id,
            name: $1.name,
            description: $0,
            notes: $1.notes,
            completed: $1.completed,
            synced: $1.synced,
            selected: $1.selected
        )
    }
)

let todoNotesLens: Lens<RxToDo, String> = Lens(
    get: { $0.notes! },
    set: {
        RxToDo(
            id: $1.id,
            name: $1.name,
            description: $1.description,
            notes: $0,
            completed: $1.completed,
            synced: $1.synced,
            selected: $1.selected
        )
    }
)

let todoCompletedLens: Lens<RxToDo, Bool> = Lens(
    get: { $0.completed},
    set: {
        RxToDo(
            id: $1.id,
            name: $1.name,
            description: $1.description,
            notes: $1.notes,
            completed: $0,
            synced: $1.synced,
            selected: $1.selected
        )
    }
)

let todoSyncedLens: Lens<RxToDo, Bool> = Lens(
    get: { $0.synced},
    set: {
        RxToDo(
            id: $1.id,
            name: $1.name,
            description: $1.description,
            notes: $1.notes,
            completed: $1.completed,
            synced: $0,
            selected: $1.selected
        )
    }
)
