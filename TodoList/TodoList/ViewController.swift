//
//  ViewController.swift
//  TodoList
//
//  Created by 이치훈 on 2023/02/21.
//

import UIKit
import CoreData

enum PriorityLevel: Int64 {
    case level1
    case level2
    case level3
}
extension PriorityLevel {
    var color: UIColor {
        switch self {
        case .level1:
            return .green
        case .level2:
            return .orange
        case .level3:
            return .red
        }
    }
}

//MARK: - ViewController

class ViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var todoTableView: UITableView!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var todoList = [TodoList]()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ToDo List"
        self.customNavigationBar()
        
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
        
        fetchData()
        self.todoTableView.reloadData()
    }
    
    //MARK: CoreData logic
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        let context = appdelegate.persistentContainer.viewContext
        do{
            self.todoList = try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
        
        
    }
    
    func customNavigationBar() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        addItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = addItem

        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = .blue.withAlphaComponent(0.5)
        
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance

    }
    
    @objc func addNewTodo() {
        let detailVC = TodoDetailViewController(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        self.present(detailVC, animated: true)
    }

}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        //set Title
        cell.topTitleLabel.text = todoList[indexPath.row].title
        
        //set Date
        if let hasDate = todoList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd hh:mm:ss"
            let dateString = formatter.string(from: hasDate)
            
            cell.dateLabel.text = dateString
        }else{
            cell.dateLabel.text = ""
        }
        
        //set Priority
        let priority = todoList[indexPath.row].prioirtyLevel
        let priorityColor = PriorityLevel(rawValue: priority)?.color
        cell.priorityView.backgroundColor = priorityColor
        cell.priorityView.layer.cornerRadius = cell.priorityView.bounds.height / 2
        
        return cell
    }
    
    
    
}
 
//MARK: - TodoDetailViewControllerDelegate

extension ViewController: TodoDetailViewControllerDelegate {
    func didFinishSaveData() {
        self.fetchData()
        self.todoTableView.reloadData()
    }
    
    
}
