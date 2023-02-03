//
//  ViewController.swift
//  Setting_Clone_App
//
//  Created by 이치훈 on 2023/02/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        let nib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: "ProfileTableViewCell")
    }


}

