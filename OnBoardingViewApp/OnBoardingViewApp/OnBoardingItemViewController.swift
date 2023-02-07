//
//  OnBoardingItemViewController.swift
//  OnBoardingViewApp
//
//  Created by 이치훈 on 2023/02/07.
//

import UIKit

class OnBoardingItemViewController: UIViewController {

    @IBOutlet private weak var topImage: UIImageView!
    @IBOutlet private weak var mainTitleLabel: UILabel!{
        didSet{
            mainTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        }
    }
    
    var topImagePara: UIImage?
    var mainTitlePara = ""
    var descriptionPara = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.topImage.image = topImagePara
        self.mainTitleLabel.text = mainTitlePara
        self.descriptionLabel.text = descriptionPara
    }


    

}
