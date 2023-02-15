//
//  DetailViewController.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/16.
//

import UIKit

class DetailViewController: UIViewController {

    var movieResult: Result?
    
    @IBOutlet weak var movieContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            self.titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            self.descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
    }
    


}
