//
//  Video.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 21/04/21.
//

import Foundation

struct Video: Codable {
    let id: Int
    let results: [VideoResult]
}

struct VideoResult: Codable {
    let id: String
    let iso_639_1: String
    let iso_3166_1: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}
