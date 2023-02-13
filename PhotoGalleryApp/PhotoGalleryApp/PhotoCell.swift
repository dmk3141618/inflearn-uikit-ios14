//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by 이치훈 on 2023/02/13.
//

import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell{
    
    @IBOutlet weak var photoImageView: UIImageView!{
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func loadImage(asset: PHAsset){
        let imageManager = PHImageManager()
        
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        
        self.photoImageView.image = nil
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) { image, info in
            //저화질 이미지, 고화질 이미지 하나씩 받아옴
            
            self.photoImageView.image = image
        }
    }
    
    
}
