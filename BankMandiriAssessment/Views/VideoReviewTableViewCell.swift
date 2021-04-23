//
//  VideoReviewTableViewCell.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 22/04/21.
//

import UIKit
import SDWebImage

class VideoReviewTableViewCell: UITableViewCell {
    
    static let identifier = "VideoReviewTableViewCell"
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userPhoto)
        contentView.addSubview(userLabel)
        contentView.addSubview(reviewLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var uiConstraints: [NSLayoutConstraint] = []
    override func layoutSubviews() {
        super.layoutSubviews()
        
        uiConstraints = [
            userPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userPhoto.widthAnchor.constraint(equalToConstant: 40),
            userPhoto.heightAnchor.constraint(equalToConstant: 40),
            
            userLabel.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 10),
            userLabel.topAnchor.constraint(equalTo: userPhoto.topAnchor),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            reviewLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            reviewLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 5),
            reviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            reviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(uiConstraints)
        userPhoto.layer.cornerRadius = userPhoto.width/2
    }
    
    public func configureCell(with viewModel: VideoReviewTableViewCellViewModel) {
        layoutIfNeeded()
        isUserInteractionEnabled = false
        if let path = viewModel.author_details.avatar_path {
            let stringUrl = "https://www.themoviedb.org/t/p/w300_and_h300_face" + path
            userPhoto.sd_setImage(with: URL(string: stringUrl), completed: nil)
        }
        
        let date = String(Array(viewModel.created_at)[0..<10])
        userLabel.text = "\(viewModel.author_details.username) - \(date)"
        reviewLabel.text = viewModel.content
    }

}
