//
//  DatailsToDoAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct DetailsTodoAction: ActionType {
    let todo: RxToDo

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value.map { todo in
            guard todo == self.todo else {
                return RxToDo(
                    id: todo.id,
                    name: todo.name,
                    description: todo.description,
                    notes: todo.notes,
                    completed: todo.completed,
                    synced: todo.synced,
                    selected: false
                )
            }

            return RxToDo(
                id: self.todo.id,
                name: self.todo.name,
                description: self.todo.description,
                notes: self.todo.notes,
                completed: self.todo.completed,
                synced: self.todo.synced,
                selected: true
            )
        }

        return state
    }
}
