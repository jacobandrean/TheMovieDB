//
//  VideoReviewCollectionViewCellViewModel.swift
//  BankMandiriAssessment
//
//  Created by Jacob Andrean on 22/04/21.
//

import Foundation

/*
 {
     "author": "SWITCH.",
     "author_details": {
         "name": "SWITCH.",
         "username": "maketheSWITCH",
         "avatar_path": "/klZ9hebmc8biG1RC4WmzNFnciJN.jpg",
         "rating": 8.0
     },
     "content": "As pure popcorn entertainment and the culmination of the Monsterverse saga, 'Godzilla vs. Kong' delivers the goods in an unexpectedly big way. This film is essential viewing for those who might like to watch a lizard punch an ape.\r\n- Jake Watt\r\n\r\nRead Jake's full article...\r\nhttps://www.maketheswitch.com.au/article/review-godzilla-vs-kong-hugely-entertaining",
     "created_at": "2021-03-24T22:20:16.047Z",
     "id": "605bbb20988afd003d996bb3",
     "updated_at": "2021-03-24T22:20:16.047Z",
     "url": "https://www.themoviedb.org/review/605bbb20988afd003d996bb3"
 },
 */



struct VideoReviewCollectionViewCellViewModel {
    let author_details: AuthorDetail
    let content: String
    let created_at: String
    
}
