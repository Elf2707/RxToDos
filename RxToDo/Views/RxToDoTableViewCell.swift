//
//  RxToDoTableViewCell.swift
//  RxToDo
//
//  Created by Elf on 12.06.2018.
//  Copyright © 2018 Elf. All rights reserved.
//

import UIKit

class RxToDoTableViewCell: UITableViewCell {
    var todo: RxToDo? {
        didSet {
            updateUI()
        }
    }

    func configure(_ todo: RxToDo) {
        store.producerForTodo(todo).startWithValues {
            nextTodo in
            self.todo = nextTodo
        }
    }

    func updateUI() {
        guard let todo = todo else { return }
        accessoryType = todo.completed ? .checkmark : .none
    }
}

