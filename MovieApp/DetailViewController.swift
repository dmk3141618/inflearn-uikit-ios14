//
//  DetailViewController.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/16.
//

import UIKit
import AVKit

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let hasURL = movieResult?.previewUrl{
            self.makePlayer(urlString: hasURL)
        }
    }
    
    func makePlayer(urlString: String) {
        
        if let hasUrl = URL(string: urlString){
            let player = AVPlayer(url: hasUrl)
            let playerLayer = AVPlayerLayer(player: player)
            
            movieContainer.layer.addSublayer(playerLayer)
            
            playerLayer.frame = movieContainer.bounds
            
            player.play()
        }
        
    }
    


}
