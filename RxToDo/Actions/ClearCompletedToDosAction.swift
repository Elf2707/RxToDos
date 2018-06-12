//
//  ClearCompletedToDosAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct ClearCompletedTodosAction: DynamicActionType {
    func call() {
        let todos = store.completedTodos.first()?.value ?? []
        todos.forEach {
            todo in
            store.dispatch(DeleteTodoAction(todo: todo))
        }
    }
}
