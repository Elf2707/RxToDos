//
//  SetFilterAction.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import Delta

struct SetFilterAction: ActionType {
    let filter: RxToDoFilter

    func reduce(state: State) -> State {
        state.filter.value = filter
        return state
    }
}

