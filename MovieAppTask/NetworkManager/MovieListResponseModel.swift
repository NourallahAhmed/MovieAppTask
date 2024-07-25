//
//  MovieListResponseModel.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
struct MovieListResponseModel  : Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

// MARK: - Result
struct Movie : Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
