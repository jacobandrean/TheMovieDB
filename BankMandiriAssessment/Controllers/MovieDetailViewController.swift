//
//  MovieDetailViewController.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController, YTPlayerViewDelegate {

    private let youtubePlayer: YTPlayerView = {
        let youtubePlayer = YTPlayerView()
        youtubePlayer.backgroundColor = .black
        return youtubePlayer
    }()
    
    private let movieResult: MovieResult
    private var videoResult: VideoResult?
    
    init(movieResult: MovieResult) {
        self.movieResult = movieResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        youtubePlayer.frame = view.bounds
    }
    
    private func fetchData() {
        APICaller.shared.getVideo(for: movieResult.id) { [weak self] (result) in
            switch result {
            case .success(let videoResult):
                self?.videoResult = videoResult
                if let videoKey = self?.videoResult?.key {
                    DispatchQueue.main.async {
                        self?.configureYoutubePlayer(videoKey: videoKey)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureYoutubePlayer(videoKey: String) {
        view.addSubview(youtubePlayer)
        youtubePlayer.load(withVideoId: videoKey,
                           playerVars: ["playsinline": 1])
        youtubePlayer.delegate = self
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
}
