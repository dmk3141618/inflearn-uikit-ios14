//
//  GeneralCell.swift
//  Setting_Clone_App
//
//  Created by 이치훈 on 2023/02/05.
//

import UIKit

class GeneralCell: UITableViewCell {

    @IBOutlet weak var leftTitle: UILabel!
    
    @IBOutlet weak var rightImage: UIImageView! {
        didSet{
            rightImage.image = UIImage(systemName: "chevron.right")
        }
        //rightImage 시작점
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
