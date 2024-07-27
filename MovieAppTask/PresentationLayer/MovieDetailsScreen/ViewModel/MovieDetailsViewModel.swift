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
    @Published internal var movie : MovieModel?
    @Published private(set) var isLoadingCompleted : Bool = false
    
    private var movieID : Int
    internal var fetchMovieDetailsUseCase : FetchMovieDetailsUseCase<AnyPublisher<MovieModel, Error>>
    internal var anyCancelable = Set<AnyCancellable>()
    
    init(movie: MovieModel? = nil, movieID: Int , fetchMovieUseCase : FetchMovieDetailsUseCase<AnyPublisher<MovieModel, Error>>) {
        self.movie = movie
        self.movieID = movieID
        self.fetchMovieDetailsUseCase = fetchMovieUseCase
        self.getMovieDetails(id: movieID)
    }
    
    func getMovieDetails(id: Int){
        
        DispatchQueue.global().async { [weak self] in
            guard let  self = self else { return}
            fetchMovieDetailsUseCase.execute(input: id, networkManager: NetworkManager.shared)
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
    
}
