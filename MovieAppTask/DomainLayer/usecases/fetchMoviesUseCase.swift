//
//  fetchMoviesUseCase.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import Combine
import Moya


class FetchMoviesUseCase<T> : BaseUseCase {
   
    
    typealias ResponseType = AnyPublisher<MovieListResponseModel, MoyaError>
    
    typealias InputType = Int
    
    typealias NetworkManager = MovieListNetworkManagerProtocol

    func execute(input: Int, networkManager: NetworkManager) -> AnyPublisher<MovieListResponseModel, MoyaError> {
        return networkManager.fetchMovieList(.movieList(page: input))
    }
  
    

    
}
