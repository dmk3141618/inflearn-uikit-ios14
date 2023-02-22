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
    
    // MARK: Properties
    
    weak var delegate: TodoDetailViewControllerDelegate?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var priority: PriorityLevel?

    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
    //MARK: Button logic

    @IBAction func setPriority(_ sender: UIButton) {
        
        self.lowButton.backgroundColor = .clear
        self.normalButton.backgroundColor = .clear
        self.highButton.backgroundColor = .clear
        
        switch sender.tag {
        case 1:
            priority = .level1
            lowButton.backgroundColor = priority?.color
        case 2:
            priority = .level2
            normalButton.backgroundColor = priority?.color
        case 3:
            priority = .level3
            highButton.backgroundColor = priority?.color
        default:
            break
        }
    }
    
    
    @IBAction func saveTodo(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let entityDescription
                = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else {return}
        
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else {return}
        
        object.title = self.titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        object.prioirtyLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        delegate?.didFinishSaveData()
        
        self.dismiss(animated: true)
    }
    
    
   

}
