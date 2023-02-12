//
//  ViewController.swift
//  OnBoardingViewApp
//
//  Created by 이치훈 on 2023/02/07.
//

import UIKit

class ViewController: UIViewController {

    var didShowOnBoardingView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didShowOnBoardingView == false {
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            
            pageVC.modalPresentationStyle = .fullScreen
            
            didShowOnBoardingView = true
            self.present(pageVC, animated: true)
        }
        
    }

    
    
}

