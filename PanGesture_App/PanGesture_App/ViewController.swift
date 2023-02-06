//
//  ViewController.swift
//  PanGesture_App
//
//  Created by 이치훈 on 2023/02/06.
//

import UIKit

enum DragType {
    case x
    case y
    case none
}

class ViewController: UIViewController {

    var dragType = DragType.none
    
    let myView = DraggableView()
    
    @IBOutlet weak var xySegument: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.dragType = .none
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .green
        
        xySegument.selectedSegmentIndex = 2
        
        self.view.addSubview(myView)
    }

    @IBAction func selectPanType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            dragType = .x
        case 1:
            dragType = .y
        case 2:
            dragType = .none
        default:
            break
        }
        
        myView.dragType = self.dragType
    }
    
}

