//
//  ProfileTableViewCell.swift
//  Setting_Clone_App
//
//  Created by 이치훈 on 2023/02/03.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet var descriptionInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let profileHeight: CGFloat = 60
        profileImageView.layer.cornerRadius = profileHeight / 2
        
        title.textColor = .blue
        title.font = UIFont.systemFont(ofSize: 20)
        
        descriptionInfo.textColor = .darkGray
        descriptionInfo.font = UIFont.systemFont(ofSize: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
