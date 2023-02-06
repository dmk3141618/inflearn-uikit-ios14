//
//  ViewController.swift
//  PanGesture_App
//
//  Created by 이치훈 on 2023/02/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = DraggableView()
        
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .green
        
        self.view.addSubview(myView)
    }

    @IBAction func selectPanType(_ sender: Any) {
        
        switch sender.selected{
            
        }
        
    }
    
}

