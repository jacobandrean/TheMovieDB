//
//  MovieCollectionViewCell.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }
    
    func configureCell(with viewModel: MovieCollectionViewCellViewModel) {
        guard let posterPath = viewModel.poster_path,
              let imageURL = URL(string: "https://www.themoviedb.org/t/p/w1280\(posterPath)") else {
            return
        }
        movieImageView.sd_setImage(with: imageURL, completed: nil)
    }
}
