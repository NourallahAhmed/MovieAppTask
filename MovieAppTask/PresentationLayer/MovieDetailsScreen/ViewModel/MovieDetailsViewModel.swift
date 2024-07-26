//
//  MovieDetailsViewModel.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import Combine


protocol MovieDetailsProtocol {
    func getMovieDetails(id: Int)
}
class MovieDetailsViewModel  : MovieDetailsProtocol {
    @Published private(set) var movie : MovieModel?
    @Published private(set) var isLoadingCompleted : Bool = false
    
    private var movieID : Int
    private var fetchMovieDetailsUseCase = FetchMovieDetails<AnyPublisher<MovieModel, Error>>()
    private var anyCancelable = Set<AnyCancellable>()
    
    init(movie: MovieModel? = nil, movieID: Int) {
        self.movie = movie
        self.movieID = movieID
        self.getMovieDetails(id: movieID)
    }
    
    func getMovieDetails(id: Int){
        fetchMovieDetailsUseCase.execute(input: id)
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.isLoadingCompleted = true
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
