//
//  Store.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import Delta

struct Store: StoreType {
    var state: ObservableProperty<State>
    init(state: State) {
        self.state = ObservableProperty(state)
    }
}

var store = Store(state: State())
