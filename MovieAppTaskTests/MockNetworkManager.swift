//
//  MockNetworkManager.swift
//  MovieAppTaskTests
//
//  Created by NourAllah Ahmed on 27/07/2024.
//

import Foundation
import Combine
import Moya
@testable import MovieAppTask

class MockNetworkManager : MovieListNetworkManagerProtocol  , Mockable {
    
    
     func fetchMovieList(_ endPoint: MovieAPIs) -> AnyPublisher<MovieListResponseModel, MoyaError> {
         return Just(loadJson(fileName: "MovieListJson", type: MovieListResponseModel.self))  .setFailureType(to: MoyaError.self)
             .eraseToAnyPublisher()
    }
}
extension MockNetworkManager : MovieDetailsNetworkManagerProtocol {
    func fetchMovieDetails(_ endPoint: MovieAppTask.MovieAPIs) -> AnyPublisher<MovieAppTask.MovieModel, Moya.MoyaError> {
        return Just(loadJson(fileName: "MovieDetailsJson", type: MovieModel.self))  .setFailureType(to: MoyaError.self)
            .eraseToAnyPublisher()
    }
    
    
    
   
}

