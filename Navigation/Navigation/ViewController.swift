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
        
        guard let backImage = UIImage(named: "img")?.withRenderingMode(.alwaysOriginal) else {return}
        
        let newImage = self.resizeImage(image: backImage, newWidth: 40, newHeight: 40)
        
        
        self.navigationController?.navigationBar.backIndicatorImage = newImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        //self.navigationController?.navigationBar.tintColor = .orange
        
        self.navigationItem.backButtonTitle = ""
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        
        let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: newImageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        return newImage
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

