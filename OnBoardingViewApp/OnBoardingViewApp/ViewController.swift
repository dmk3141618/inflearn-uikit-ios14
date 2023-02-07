//
//  ViewController.swift
//  OnBoardingViewApp
//
//  Created by 이치훈 on 2023/02/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        pageVC.modalPresentationStyle = .fullScreen
        
        self.present(pageVC, animated: true)
    }

}

