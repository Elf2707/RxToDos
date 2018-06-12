//
//  State.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Delta

extension MutableProperty: Delta.ObservablePropertyType {
    public typealias ValueType = Value
}

private let initialTodos: [RxToDo] = []

struct State {
    let todos = MutableProperty(initialTodos)
    let filter = MutableProperty(RxToDoFilter.all)
    let notSynced = MutableProperty(RxToDoFilter.notSyncedWithBackend)
    let selectedTodoItem = MutableProperty(RxToDoFilter.selected)
}
