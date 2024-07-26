//
//  fetchMovieDetailsUseCase.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import Combine
class FetchMovieDetails<T> : BaseUseCase {
   
 
    
    typealias ResponseType = AnyPublisher<MovieModel, Error>
    
    typealias InputType = Int
    
    
    
    func execute(input: Int) -> AnyPublisher<MovieModel, any Error> {
        return NetworkManager.shared.fetchMovieDetails(movieId: input)
    }
    

    
}
