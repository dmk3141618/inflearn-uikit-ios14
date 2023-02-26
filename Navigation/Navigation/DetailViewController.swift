//
//  DetailViewController.swift
//  Navigation
//
//  Created by 이치훈 on 2023/02/26.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        self.statusBar?.backgroundColor = .red
    }
    

  
    

}

//MARK: - UIViewController

extension UIViewController { //실제론 파일을 따로 만들어서 생성할 것!
    
    var statusBar: UIView? {
        
        //status bar design
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        let window = UIApplication.shared.windows.filter {
            $0.isKeyWindow
        }.first
        
        if let hasStatusBar = sceneDelegate?.statusBarView {
            //self.view.addSubview(hasStatusBar)
            window?.addSubview(hasStatusBar)
        }
        
        return sceneDelegate?.statusBarView
    }
    
    
}
