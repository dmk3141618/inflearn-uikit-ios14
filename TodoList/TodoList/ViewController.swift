//
//  ViewController.swift
//  TodoList
//
//  Created by 이치훈 on 2023/02/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var todoTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ToDo List"
        self.customNavigationBar()
        
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        return cell
    }
    
    
    
}
 
