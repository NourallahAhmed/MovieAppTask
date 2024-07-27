//
//  fetchMovieDetailsUseCase.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import Combine
import Moya
class FetchMovieDetailsUseCase<T> : BaseUseCase {
  
   
    
    typealias ResponseType = AnyPublisher<MovieModel, MoyaError>
    
    typealias InputType = Int
    typealias NetworkManager = MovieDetailsNetworkManagerProtocol
    
    
    func execute(input: Int, networkManager: NetworkManager) -> AnyPublisher<MovieModel, MoyaError> {
        return networkManager.fetchMovieDetails(.movieDetails(id: "\(input)"))
    }
    
    

    

    
}
