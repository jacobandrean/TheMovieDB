//
//  MovieDetailViewController.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
                return MovieDetailViewController.createSectionLayout()
            }
        )
    )
    
    private let videoDetailView = VideoPlayerView()
    
    private let movieResult: MovieResult
    private var videoResult: VideoResult?
    private var reviewResults: [ReviewResult] = []
    
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
        view.addSubview(videoDetailView)
        configureCollectionView()
        fetchVideo()
        fetchVideoReview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoDetailView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/3)
        collectionView.frame = CGRect(x: 0, y: videoDetailView.bottom, width: view.width, height: view.height-(view.height/3))
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(
            VideoDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: VideoDetailCollectionViewCell.identifier
        )
//        collectionView.register(
//            LoadingIndicatorCollectionReusableView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
//            withReuseIdentifier: LoadingIndicatorCollectionReusableView.identifier
//        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func fetchVideo() {
        APICaller.shared.getVideo(for: movieResult.id) { [weak self] (result) in
            switch result {
            case .success(let videoResult):
                self?.videoResult = videoResult
                if let key = self?.videoResult?.key {
                    DispatchQueue.main.async {
                        self?.videoDetailView.configureVideoPlayer(with: VideoPlayerViewViewModel(key: key))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchVideoReview() {
        APICaller.shared.getReviews(for: movieResult.id) { [weak self] (result) in
            switch result {
            case .success(let reviewResults):
                self?.reviewResults.append(contentsOf: reviewResults)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return reviewResults.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoDetailCollectionViewCell.identifier, for: indexPath) as? VideoDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: VideoDetailCollectionViewCellViewModel(title: movieResult.title, overview: movieResult.overview))
        let x = [UIColor.yellow, UIColor.systemPink, UIColor.red, UIColor.systemTeal]
        cell.backgroundColor = .yellow//x[indexPath.row]
        return cell
    }
    
    static func createSectionLayout() -> NSCollectionLayoutSection {
//        let supplementaryViews = [
//            NSCollectionLayoutBoundarySupplementaryItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .absolute(50)
//                ),
//                elementKind: UICollectionView.elementKindSectionFooter,
//                alignment: .bottom)
//        ]
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(100)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(100)
            ),
            subitem: item,
            count: 1
        )
//        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
//        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
    
}
