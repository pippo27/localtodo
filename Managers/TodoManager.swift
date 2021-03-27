//
//  TodoManager.swift
//  Todo
//
//  Created by Arthit Thongpan on 27/3/2564 BE.
//

import Foundation
import UIKit

class TodoManager {
    static let shared = TodoManager()
    fileprivate let TODOS_KEY = "todos"
    
    var todos: [Todo] {
        set {
            setTodos(newValue)
        }
        
        get {
            let defaults = UserDefaults.standard
            guard let todosData = defaults.object(forKey: TODOS_KEY) as? Data else { return [] }
            let decoder = JSONDecoder()
            let todos = try? decoder.decode([Todo].self, from: todosData)
            return todos ?? []
        }
    }
    
    fileprivate func setTodos(_ todos: [Todo]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todos) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: TODOS_KEY)
            defaults.synchronize()
            print("Save todos")
        }
    }
    
    fileprivate func save() {
        setTodos(self.todos)
    }
    
    func createTodo(_ description: String, image: UIImage?, completion: (Todo?) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let createAt = dateFormatter.string(from: Date())
        
        var dic = ["description": description, "createdAt": createAt]
        if let imageData = image, let base64 = imageData.jpegData(compressionQuality: 1)?.base64EncodedString() {
            dic["imageData"] = base64
        }
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dic) {
            let decoder = JSONDecoder()
            do {
                let todo = try decoder.decode(Todo.self, from: jsonData)
                todos.append(todo)
                completion(todo)
                
            } catch {
                print("Error: \(error)")
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
   
}
