//
//  VideoDetailCollectionViewCell.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit

class VideoDetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoDetailCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(overviewLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
//        titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: 1)
//        titleLabel.sizeToFit()
//        overviewLabel.frame = CGRect(x: 0, y: titleLabel.bottom, width: width, height: 1)
//        overviewLabel.sizeToFit()
    }
    
    public func configureCell(with viewModel: VideoDetailCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        overviewLabel.text = viewModel.overview
    }
}
