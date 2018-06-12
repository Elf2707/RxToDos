//
//  ToggleCompletedAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct ToggleCompletedAction: ActionType {
    let todo: RxToDo

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value.map {
            todo in
            guard todo == self.todo else { return todo }

            return RxToDo(
                id: todo.id,
                name: todo.name,
                description: todo.description,
                notes: todo.notes,
                completed: !todo.completed,
                synced: !todo.synced,
                selected: todo.selected
            )
        }

        return state
    }
}
