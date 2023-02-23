//
//  TodoDetailViewController.swift
//  TodoList
//
//  Created by 이치훈 on 2023/02/22.
//

import UIKit
import CoreData

protocol TodoDetailViewControllerDelegate: AnyObject {
    func didFinishSaveData()
}

class TodoDetailViewController: UIViewController {
    
    // MARK: -Properties
    
    weak var delegate: TodoDetailViewControllerDelegate?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedTodoList: TodoList?
    var priority: PriorityLevel?

    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let hasData = selectedTodoList {
            self.titleTextField.text = hasData.title
            
            self.priority = PriorityLevel(rawValue: hasData.prioirtyLevel)
            self.makePriorityButtonDesign()
            self.saveButton.setTitle("update", for: .normal)
            self.deleteButton.isHidden = false
        }else{
            self.saveButton.setTitle("save", for: .normal)
            self.deleteButton.isHidden = true
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        highButton.layer.cornerRadius = highButton.bounds.height / 2
        highButton.tintColor = .black
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        normalButton.tintColor = .black
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        lowButton.tintColor = .black
        saveButton.tintColor = .black
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
        cancelButton.tintColor = .black
        cancelButton.layer.cornerRadius = cancelButton.bounds.height / 2
    }
    
    //MARK: - Button logic

    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default:
            break
        }
        
        self.makePriorityButtonDesign()
    }
    
    func makePriorityButtonDesign() {
        self.lowButton.backgroundColor = .clear
        self.normalButton.backgroundColor = .clear
        self.highButton.backgroundColor = .clear
        
        switch self.priority {
        case .level1:
            lowButton.backgroundColor = priority?.color
        case .level2:
            normalButton.backgroundColor = priority?.color
        case .level3:
            highButton.backgroundColor = priority?.color
        default:
            break
        }
    }
    
    //MARK: -SaveButton
    
    @IBAction func saveTodo(_ sender: Any) {
        
        if selectedTodoList != nil {
            self.updateTodo()
        }else{
            self.saveTodo()
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    func saveTodo() {
        guard let entityDescription
                = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else {return}
        
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else {return}
        
        object.title = self.titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        object.prioirtyLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func updateTodo() {
        guard let hasData = selectedTodoList else {return}
        guard let hasUUID = hasData.uuid else {return}
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        do{
            let loadedData = try context.fetch(fetchRequest)
            
            loadedData.first?.title = self.titleTextField.text
            loadedData.first?.date = Date()
            loadedData.first?.prioirtyLevel = self.priority?.rawValue ?? PriorityLevel.level1.rawValue
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }catch{
            print(error)
        }
    }
    
    //MARK: -DeleteButton
    
    @IBAction func deleteTodo(_ sender: UIButton) {
        guard let hasData = self.selectedTodoList else {return}
        guard let hasUUID = hasData.uuid else {return}
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        do{
            let loadData = try context.fetch(fetchRequest)
            
            if let loadFirstData = loadData.first {
                context.delete(loadFirstData)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            
        }catch{
            print(error)
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
   

}
