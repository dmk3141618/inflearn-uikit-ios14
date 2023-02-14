//
//  MovieCell.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/14.
//

import UIKit

class MovieCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        }
    }
    @IBOutlet weak var dateLabel: UILabel!{
        didSet{
            dateLabel.font = .systemFont(ofSize: 13, weight: .light)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = .systemFont(ofSize: 14 , weight: .light)
        }
    }
    @IBOutlet weak var priceLabel: UILabel!{
        didSet{
            priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        }
    }
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    
    
}
