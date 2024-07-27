//
//  MockMovieDetailsViewModel.swift
//  MovieAppTaskTests
//
//  Created by NourAllah Ahmed on 28/07/2024.
//

import Foundation
@testable import MovieAppTask
class MockMovieDetailsViewModel  : MovieDetailsViewModel {
    
    
    override func getMovieDetails(id: Int) {
        fetchMovieDetailsUseCase.execute(input: id, networkManager: MockNetworkManager()) .sink { [weak self] completion in
            switch completion {
            case .finished:
                print("isLoading = false")
            case .failure(let error):
                print( "Error = \(error)")
            }
        }
        receiveValue: {  [weak self] movieModel in
            self?.movie = movieModel
            
        }.store(in: &anyCancelable)
    }
}
