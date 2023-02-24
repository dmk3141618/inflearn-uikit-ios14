//
//  ViewController.swift
//  CustomButton
//
//  Created by 이치훈 on 2023/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customButton: RotateButton! // green Button
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton.selectTypeCallback = { upDownType in
            print(upDownType)
        }
        
        let myButton = RotateButton()
        self.view.addSubview(myButton)
        
        
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        //myButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myButton.backgroundColor = .orange
        myButton.setTitle("my custom button", for: .normal)
        myButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        myButton.layer.cornerRadius = 15
        
        print(myButton.frame.height)
    }
    
    
    
    
}

