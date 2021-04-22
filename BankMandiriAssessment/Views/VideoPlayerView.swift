//
//  VideoDetailView.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayerView: UIView, YTPlayerViewDelegate {

    private let youtubePlayer: YTPlayerView = {
        let youtubePlayer = YTPlayerView()
        youtubePlayer.backgroundColor = .black
        return youtubePlayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(youtubePlayer)
        youtubePlayer.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        youtubePlayer.frame = bounds
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        youtubePlayer.playVideo()
    }
    
    public func configureVideoPlayer(with viewModel: VideoPlayerViewViewModel) {
        youtubePlayer.load(withVideoId: viewModel.key,
                           playerVars: ["playsinline": 1])
    }
    
}
