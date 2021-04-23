//
//  MoviesViewController.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit

class MoviesViewController: UIViewController {

    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
                return MoviesViewController.createSectionLayout()
            }
        )
    )
    
    private let genre: Genre
    private var movies: [MovieResult] = []
    private var pageNumber = 1
    private var isFetching = false
    
    init(genre: Genre) {
        self.genre = genre
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = genre.name
        view.backgroundColor = .systemBackground
        configureCollectionView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier
        )
        collectionView.register(
            LoadingIndicatorCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: LoadingIndicatorCollectionReusableView.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
        print(pageNumber)
        if !isFetching {
            isFetching = true
            APICaller.shared.getMovies(for: genre, page: pageNumber) { [weak self] (result) in
                sleep(1)
                switch result {
                case .success(let movies):
                    self?.movies.append(contentsOf: movies)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                    self?.pageNumber+=1
                    self?.isFetching = false
                case .failure(let error):
                    print(error)
                    self?.pageNumber+=1
                    self?.isFetching = false
                    self?.fetchData()
                }
            }
        }
    }

}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(
            with: MovieCollectionViewCellViewModel(
                with: movies[indexPath.row]
            )
        )
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = MovieDetailViewController(movieResult: movies[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: LoadingIndicatorCollectionReusableView.identifier,
                for: indexPath) as? LoadingIndicatorCollectionReusableView else {
            return UICollectionReusableView()
        }
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            if !self.isFetching {
                fetchData()
            }
        }
    }
    
    static func createSectionLayout() -> NSCollectionLayoutSection {
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom)
        ]
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(200)
            ),
            subitem: item,
            count: 3
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
    
}
