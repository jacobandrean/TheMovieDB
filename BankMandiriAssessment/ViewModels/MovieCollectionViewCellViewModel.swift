//
//  MovieCollectionViewCellViewModel.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import Foundation

struct MovieCollectionViewCellViewModel {
    let poster_path: String?
    
    init(with model: MovieResult) {
        poster_path = model.poster_path
    }
}
