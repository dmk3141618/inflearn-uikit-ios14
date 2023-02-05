//
//  MyIDViewController.swift
//  Setting_Clone_App
//
//  Created by 이치훈 on 2023/02/05.
//

import UIKit

class MyIDViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            self.nextButton.tintColor = .lightGray
            self.nextButton.isEnabled = false
            //nextButton initial setting
        }
    }
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.idTextField.placeholder = "Email"
        self.idTextField.borderStyle = .none
        
        self.idTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    //addTarget Called
    @objc func textFieldDidChange(sender: UITextField){
        if sender.text?.isEmpty == true {
            self.nextButton.tintColor = .lightGray
            self.nextButton.isEnabled = false
        }else{
            self.nextButton.tintColor = .link
            self.nextButton.isEnabled = true
        }
    }
    
    @IBAction func moveToCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func moveToNext(_ sender: Any) {
        NSLog("moveToNext")
        /*
         로그인 후 다음(비밀번호 입력창)으로 넘어가는 로직
        아이디 일치할때 넘어가는 로직 작성해야 함
         */
    }
    
}
  
