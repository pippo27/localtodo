//
//  TodoListViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 27/3/2564 BE.
//

import UIKit
import SDCAlertView

class TodoListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var noDataView: UIView!
    
    var todos: [Todo] {
        return TodoManager.shared.todos
    }
    
    private var counter: Int?  // เก็บเวลา ว่าสร้างรายการล่าสุดไปเท่าไหร่
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let counter = self.counter {
            AlertController.alert(message: "ใช้เวลาในการสร้างรายการล่าสุด \(counter) วินาที", actionTitle: "ตกลง")
            self.counter = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if todos.count == 0 {
            tableView.backgroundView = noDataView
        } else {
            tableView.backgroundView = nil
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "CreateTodo", sender: nil)
    }
    
    // MARK: - Unwind Segue Methods
    
    @IBAction func cancelCreateTodoToTodoListViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func createTodoToTodoListViewController(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
        if let controller = segue.source as? CreateTodoTableViewController {
            self.counter = controller.counter
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "TodoDetail":
            let todoDetailVC = segue.destination as! TodoDetailTableViewController
            todoDetailVC.todo = sender as! Todo
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoTableViewCell
        cell.todo = todos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TodoDetail", sender: todos[indexPath.row])
    }
}
