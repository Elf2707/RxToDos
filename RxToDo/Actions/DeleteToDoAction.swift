//
//  DeleteToDoAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct DeleteTodoAction: ActionType {
    let todo: RxToDo
    func reduce(state: State) -> State {
        state.todos.value = state.todos.value.filter { $0 != self.todo }
        return state
    }
}
