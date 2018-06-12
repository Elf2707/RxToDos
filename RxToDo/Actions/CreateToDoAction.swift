//
//  CreateToDoAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct CreateTodoAction: ActionType {
    let id: Int
    let name: String
    let description: String
    let notes: String

    var todo: RxToDo {
        return RxToDo(
            id: id,
            name: name,
            description: description,
            notes: notes,
            completed: false,
            synced: false,
            selected: false
        )
    }

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value + [todo]
        return state
    }
}
