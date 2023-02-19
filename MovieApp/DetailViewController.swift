//
//  DetailViewController.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/16.
//

import UIKit
import AVKit
import Combine

class DetailViewController: UIViewController {

    //MARK: - Properties
    var movieResult: Result?
    var movieContainer: UIView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var playerLayer: AVPlayerLayer!
    var emptyView: UIView!
    var url: String! {
        didSet {
            makePlayer(urlString: url) {
                guard $0 else {
                    print("url가 잘못됬거나 player 초기화가 잘못됨.")
                    // 동영상이 안 보여질 때 초록초록하게 해봄
                    self.movieContainer.backgroundColor = .systemGreen
                    return
                }
                self.playerLayer.player?.play()
            }
        }
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = movieContainer.bounds
    }
}

//MARK: - Helpers
extension DetailViewController {
    // player를 만들어주는 함수
    func makePlayer(urlString: String, completion: @escaping(Bool)->Void) {
        guard let hasUrl = URL(string: urlString) else {
            completion(false)
            return
        }
        let asset = AVAsset(url: hasUrl)
        let item = AVPlayerItem(asset: asset)
        playerLayer = AVPlayerLayer(player: AVPlayer(playerItem: item))
        setupPlayerLayers(playerLayer)
        completion(true)
        
    }
    
    //MARK: - AVPlayer는 UIView타입이 아님. CALayer인 AVPlayerLayer에 다뤄져야함.
    // UIView는 어차피 CALayer's wrapper라서 calayer 나중에 공부해야겠다,,
    func setupPlayerLayers(_ target: AVPlayerLayer) {
        movieContainer.layer.addSublayer(target)
        target.videoGravity = .resizeAspectFill
        movieContainer.layer.shadowOffset = CGSize(width: 0, height: 10)
        movieContainer.layer.shadowColor = UIColor.black.cgColor
        movieContainer.layer.shadowOpacity = 0.23
    }
    
    func configure() {
        // 기본적인 subview들 초기화
        setupSubviews()
        // 이전 화면에서 url을 받았다면?
        guard let hasUrl = movieResult?.previewUrl else { return
        }
        self.url = hasUrl
    }
}







//여기는 안봐도됨 그냥 레이아웃 설정하는거야 코드로 사실상 이 위에 까지 가 끝

//MARK: - Subview's helpers
extension DetailViewController {
    
    func setupSubviews() {
        initSubviews()
        addSubviews()
        
        setupEmptyViewConstrations()
        setupContainerConstraints()
        setupTitleConstraints()
        setupDescriptionLabelConstraints()
        setupEachViewIntrinsicSize()
    }
    
    func initSubviews() {
        emptyView = UIView()
        movieContainer = UIView()
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.text = ""
        titleLabel.text = movieResult?.trackName
        titleLabel.numberOfLines = 2
        descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        descriptionLabel.text = movieResult?.longDescription
        descriptionLabel.numberOfLines = 0
    }
    
    func addSubviews() {
        _=[emptyView, movieContainer,
           titleLabel, descriptionLabel]
            .map{
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false}
    }
    
    func setupEachViewIntrinsicSize() {
        emptyView.setContentHuggingPriority(UILayoutPriority(250), for: .vertical)
        movieContainer.setContentHuggingPriority(UILayoutPriority(250), for: .vertical)
        titleLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
    }

}

//MARK: - Setup subview's constraints
extension DetailViewController {
    
    func setupEmptyViewConstrations() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 22)])
    }
    
    func setupContainerConstraints() {
        NSLayoutConstraint.activate([
            movieContainer.topAnchor.constraint(equalTo: emptyView.bottomAnchor),
            movieContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieContainer.heightAnchor.constraint(equalToConstant: 300)])
    }
    
    func setupTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: movieContainer.bottomAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 7),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)])
    }
    
    func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 7),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -7),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)])
    }
    
}


