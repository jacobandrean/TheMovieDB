//
//  MovieDetailViewController.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let videoPlayerView = VideoPlayerView()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    private let movieResult: MovieResult
    private var videoResult: VideoResult?
    private var reviewResults: [ReviewResult] = []
    private var pageNumber = 1
    private var totalPages = 0
    private var isFetching = false
    
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
        view.addSubview(videoPlayerView)
        configureTableView()
        fetchVideo()
        fetchVideoReview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPlayerView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/3)
        tableView.frame = CGRect(x: 0, y: videoPlayerView.bottom, width: view.width, height: view.height-(view.height/3))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(
            VideoDetailTableViewCell.self,
            forCellReuseIdentifier: VideoDetailTableViewCell.identifier
        )
        tableView.register(
            VideoReviewTableViewCell.self,
            forCellReuseIdentifier: VideoReviewTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
    }
    
    private func fetchVideo() {
        APICaller.shared.getVideo(for: movieResult.id) { [weak self] (result) in
            switch result {
            case .success(let videoResult):
                self?.videoResult = videoResult
                if let key = self?.videoResult?.key {
                    DispatchQueue.main.async {
                        self?.videoPlayerView.configureVideoPlayer(with: VideoPlayerViewViewModel(key: key))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchVideoReview() {
        if !isFetching {
            isFetching = true
            APICaller.shared.getReviews(for: movieResult.id, page: pageNumber) { [weak self] (result) in
                sleep(1)
                switch result {
                case .success(let review):
                    self?.reviewResults.append(contentsOf: review.results)
                    self?.totalPages = review.total_pages
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    self?.pageNumber+=1
                    self?.isFetching = false
                case .failure(let error):
                    print(error)
                    self?.pageNumber+=1
                    self?.isFetching = false
                }
            }
        }
    }
    
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return reviewResults.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoDetailTableViewCell.identifier, for: indexPath) as? VideoDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(
                with: VideoDetailTableViewCellViewModel(
                    title: movieResult.title,
                    release_date: movieResult.release_date,
                    overview: movieResult.overview
                )
            )
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoReviewTableViewCell.identifier, for: indexPath) as? VideoReviewTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(
                with: VideoReviewTableViewCellViewModel(
                    author_details: reviewResults[indexPath.row].author_details,
                    content: reviewResults[indexPath.row].content,
                    created_at: reviewResults[indexPath.row].created_at
                )
            )
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textAlignment = .center
        headerText.text = "User Reviews"
        return headerText
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .secondaryLabel
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return reviewResults.count == 0 ? 0 : 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return pageNumber == totalPages+2 ? 0 : 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if !self.isFetching {
            fetchVideoReview()
        }
    }
    
}
