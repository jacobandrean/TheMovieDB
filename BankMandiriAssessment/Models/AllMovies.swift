//
//  Movies.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import Foundation

struct AllMovies: Codable {
    let page: Int
    let results: [MovieResult]
    let total_results: Int
    let total_pages: Int
}

struct MovieResult: Codable {
    let poster_path: String?
    let adult: Bool
    let overview: String
    let release_date: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String?
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let vote_average: Double
}
