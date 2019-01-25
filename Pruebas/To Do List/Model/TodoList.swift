//
//  TodoList.swift
//  Pruebas
//
//  Created by Julio Banda on 1/1/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class TodoList {

    private var todos: [ChecklistItem] = []
    
    var numberOfTasks: Int {
        return todos.count
    }
    
    init() {
        todos.append(ChecklistItem( text: "Create an app",   priority: .low))
        todos.append(ChecklistItem( text: "Sleep",           priority: .medium))
        todos.append(ChecklistItem( text: "Go to work",      priority: .high))
        todos.append(ChecklistItem( text: "Eat",             priority: .low))
        todos.append(ChecklistItem( text: "Play pokemon",    priority: .later))
    }
    
    func addCheckListItem(_ item: ChecklistItem) {
        todos.append(item)
    }
    
    func delete(item index: Int) {
        todos.remove(at: index)
    }
    
    func delete(items: [IndexPath]) {
        for index in items.reversed() {
            todos.remove(at: index.row)
        }
    }
    
    func get(at index: Int) -> ChecklistItem {
        return todos[index]
    }
    
    func getIndex(for item: ChecklistItem) -> Int? {
        return todos.firstIndex(of: item)
    }
    
    func move(item: ChecklistItem, to index: Int) {
        guard let currentIndex = todos.firstIndex(of: item) else { return }
        
        todos.remove(at: currentIndex)
        todos.insert(item, at: index)
    }
    
    func retrieveAllTasks(completionHandler: (_ task: ChecklistItem) -> Void) {
        for item in todos {
            completionHandler(item)
        }
    }
}
