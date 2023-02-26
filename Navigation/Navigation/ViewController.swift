//
//  ViewController.swift
//  Navigation
//
//  Created by 이치훈 on 2023/02/25.
//

import UIKit

class ViewController: UIViewController {

    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNaviTitleView()
        self.makeBackButton()
        self.makeRightAlarmButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.naviBackgroundDesign()
    }
    
    //MARK: -Custom Navigation func
    
    func makeRightAlarmButton() {
        /*
        let image = UIImage(systemName: "alarm.fill")?.withRenderingMode(.alwaysOriginal)
        let rightItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightItemClick))
        
        let image2 = UIImage(systemName: "alarm")?.withRenderingMode(.alwaysOriginal)
        let rightItem2 = UIBarButtonItem(image: image2, style: .done, target: self, action: #selector(rightItemClick2))
        rightItem2.imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        */
        
        let btn1 = UIButton()
        btn1.setImage(UIImage(systemName: "alarm.fill"), for: .normal)
        btn1.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let btn2 = UIButton()
        btn2.setImage(UIImage(systemName: "alarm"), for: .normal)
        btn2.addTarget(self, action: #selector(rightItemClick2), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [btn1, btn2])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        
        let customItem = UIBarButtonItem(customView: stackView)
        
        self.navigationItem.rightBarButtonItem = customItem
        //self.navigationItem.rightBarButtonItems = [rightItem, rightItem2]
    }
    
    @objc func rightItemClick() {
        print("right item click")
    }
    
    @objc func rightItemClick2() {
        print("right item click2")
    }
    
    
    func naviBackgroundDesign() {
        self.navigationController?.navigationBar.backgroundColor = .orange
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.statusBar?.backgroundColor = .orange
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
        btn.backgroundColor = .green
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

