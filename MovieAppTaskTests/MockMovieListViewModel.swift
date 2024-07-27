//
//  MockFetchMovieListUseCase.swift
//  MovieAppTaskTests
//
//  Created by NourAllah Ahmed on 28/07/2024.
//

import Foundation
@testable import MovieAppTask
class MockMovieListViewModel  : MovieListViewModel {
    
    
    
    override func fetchMovies() {
        fetchMovieListUseCase.execute(input: 1, networkManager: MockNetworkManager())
            .sink { [weak self] completion in
            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                
                print("Error")

            }
        } receiveValue: { [weak self] response in
           
            self?.movieList.append(contentsOf: response.results )

            
        }.store(in: &anyCancelable)
    }
}
