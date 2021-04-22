//
//  VideoReviewCollectionViewCell.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 22/04/21.
//

import UIKit

class VideoReviewCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoReviewCollectionViewCell"
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        label.text = "asdwkamdk adkmawdmalm wkdmaldmalk - date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.text = "As pure popcorn entertainment and the culmination of the Monsterverse saga, 'Godzilla vs. Kong' delivers the goods in an unexpectedly big way. This film is essential viewing for those who might like to watch a lizard punch an ape. - Jake Watt"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userPhoto)
        addSubview(userLabel)
        addSubview(reviewLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            userPhoto.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            userPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userPhoto.widthAnchor.constraint(equalToConstant: 40),
            userPhoto.heightAnchor.constraint(equalToConstant: 40),
            
            userLabel.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 10),
            userLabel.topAnchor.constraint(equalTo: userPhoto.topAnchor),
            userLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            reviewLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            reviewLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 5),
            reviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            reviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            
            
        ])
        userPhoto.layer.cornerRadius = userPhoto.width/2
    }

//    public func configureCell(with viewModel: VideoDetailCollectionViewCellViewModel) {
//        layoutIfNeeded()
//        titleLabel.text = viewModel.title
//        overviewLabel.text = viewModel.overview
//    }
}
