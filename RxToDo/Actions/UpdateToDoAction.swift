//
//  UpdateToDoAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct UpdateTodoAction: ActionType {
    let todo: RxToDo

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value.map {
            todo in
            guard todo == self.todo else { return todo }

            return RxToDo(
                id: todo.id,
                name: self.todo.name,
                description: self.todo.description,
                notes: self.todo.notes,
                completed: self.todo.completed,
                synced: !todo.synced,
                selected: todo.selected
            )
        }

        return state
    }
}
