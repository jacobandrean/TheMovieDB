//
//  LoadingCollectionReusableView.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import UIKit

class LoadingIndicatorCollectionReusableView: UICollectionReusableView {
    static let identifier = "LoadingIndicatorCollectionReusableView"
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .secondaryLabel
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.frame = bounds
    }
    
    public func configureCollectionReusableView() {
        
    }
}
