//
//  Review.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 22/04/21.
//

import Foundation

struct Review: Codable {
    let id: Int
    let page: Int
    let results: [ReviewResult]
    let total_pages: Int
    let total_results: Int
}

struct ReviewResult: Codable {
    let author: String
    let author_details: AuthorDetail
    let content: String
    let created_at: String
    let id: String
    let updated_at: String
    let url: String
}

struct AuthorDetail: Codable {
    let name: String
    let username: String
    let avatar_path: String?
    let rating: Int?
}
