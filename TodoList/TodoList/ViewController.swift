//
//  ViewController.swift
//  TodoList
//
//  Created by 이치훈 on 2023/02/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var todoTableView: UITableView!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var todoList = [TodoList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ToDo List"
        self.customNavigationBar()
        
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
        
        fetchData()
        self.todoTableView.reloadData()
    }
    
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
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.topTitleLabel.text = todoList[indexPath.row].title
        
        if let hasDate = todoList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd hh:mm:ss"
            let dateString = formatter.string(from: hasDate)
            
            cell.dateLabel.text = dateString
        }else{
            cell.dateLabel.text = ""
        }
        
        
        return cell
    }
    
    
    
}
 
