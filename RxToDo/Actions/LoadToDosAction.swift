//
//  LoadToDosAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct LoadTodosAction: ActionType {
    let todos: [RxToDo]

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value + todos
        return state
    }
}
