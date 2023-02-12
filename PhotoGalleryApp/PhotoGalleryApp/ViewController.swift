//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 이치훈 on 2023/02/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Photo Gallery App"
        makeNavigationItem()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 1) / 2, height: 200)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        photoCollectionView.collectionViewLayout = layout
        
        photoCollectionView.dataSource = self
    }

    func makeNavigationItem(){
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(showGallery))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.leftBarButtonItem = refreshItem
    }
    
    @objc func showGallery(){
        
    }

    @objc func refresh(){
        
    }
}
extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        return cell
    }
    
}
