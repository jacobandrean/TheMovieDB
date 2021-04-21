//
//  Genre.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import Foundation

struct AllGenres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
