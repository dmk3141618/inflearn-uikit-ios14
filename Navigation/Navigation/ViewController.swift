//
//  ViewController.swift
//  Navigation
//
//  Created by 이치훈 on 2023/02/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNaviTitleView()
        self.makeBackButton()
    }
    
    func makeBackButton() {
        
//        var backImage = UIImage(systemName: "backward")
//        backImage = backImage?.withRenderingMode(.alwaysOriginal)
        
        let backImage = UIImage(systemName: "backward")?.withRenderingMode(.alwaysOriginal)
        
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .orange
        
        self.navigationItem.backButtonTitle = ""
    }
    
    func setNaviTitleView() {
        //title
//        self.title = "메인 화면"
        
        //image
//        let logo = UIImageView(image: UIImage(named: "img"))
//        logo.contentMode = .scaleAspectFit
//        logo.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        self.navigationItem.titleView = logo
        
        //button
        let btn = UIButton()
        btn.setTitle("custom button", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .orange
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.layer.cornerRadius = 21
        
        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        
        self.navigationItem.titleView = btn
    }

    @objc func testAction() {
        print("test action")
    }
    
    
    

}

