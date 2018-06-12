//
//  StoreExtensions.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Result

// MARK: Properties
extension Store {
    var todos: MutableProperty<[RxToDo]> {
        return state.value.todos
    }

    var activeFilter: MutableProperty<RxToDoFilter> {
        return state.value.filter
    }

    var selectedTodoItem: MutableProperty<RxToDoFilter> {
        return state.value.selectedTodoItem
    }
}

// MARK: SignalProducers
extension Store {
    var activeTodos: SignalProducer<[RxToDo], NoError> {
        return activeFilter.producer.flatMap(.latest) {
            filter -> SignalProducer<[RxToDo], NoError> in
            switch filter {
            case .all: return self.todos.producer
            case .active: return self.incompleteTodos
            case .completed: return self.completedTodos
            case .notSyncedWithBackend: return self.notSyncedWithBackend
            case .selected: return self.selectedTodo
            }
        }
    }

    var completedTodos: SignalProducer<[RxToDo], NoError> {
        return todos.producer.map {
            todos in
            return todos.filter { $0.completed }
        }
    }

    var incompleteTodos: SignalProducer<[RxToDo], NoError> {
        return todos.producer.map {
            todos in
            return todos.filter { !$0.completed }
        }
    }

    var incompleteTodosCount: SignalProducer<Int, NoError> {
        return incompleteTodos.map { $0.count }
    }

    var allTodosCount: SignalProducer<Int, NoError> {
        return todos.producer.map { $0.count }
    }

    var todoStats: SignalProducer<(Int, Int), NoError> {
        return allTodosCount.zip(with: incompleteTodosCount)
    }

    var notSyncedWithBackend: SignalProducer<[RxToDo], NoError> {
        return todos.producer.map {
            todos in
            return todos.filter { !$0.synced }
        }
    }

    var selectedTodo: SignalProducer<[RxToDo], NoError> {
        return todos.producer.map {
            todos in
            return todos.filter {
                todo in
                   if let selected = todo.selected {
                       return selected
                   } else {
                       return false
                   }
            }
        }
    }

    func producerForTodo(_ todo: RxToDo) -> SignalProducer<RxToDo, NoError> {
        return store.todos.producer.map {
            todos in
                return todos.filter { $0 == todo }.first
        }.skipNil()
    }
}

