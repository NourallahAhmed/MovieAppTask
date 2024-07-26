//
//  MovieListResponseModel.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation


struct MovieListResponseModel  : Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int
    enum CodingKeys: String, CodingKey {
           case page, results
           case totalPages = "total_pages"
           case totalResults = "total_results"
       }
}


