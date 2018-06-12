//
//  RxToDosViewModel.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import ReactiveCocoa

struct RxToDosViewModel {
    let todos: [RxToDo]

    func todoForIndexPath(_ indexPath: IndexPath) -> RxToDo {
        return todos[indexPath.row]
    }
}
