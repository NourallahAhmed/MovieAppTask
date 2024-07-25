//
//  NetworkManager.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import Moya
import Combine


//enum ErrorHandler : MoyaError {
//    typealias RawValue = <#type#>
//    
//    case badGateWay
//    case someThingWentWrong
//}


protocol NetworkManagerProtocol {
    
    func fetchMovieList() -> AnyPublisher< MovieListResponseModel , MoyaError>
//    func fetchMovieDetails(movieId: String) -> AnyPublisher<MovieModel , MoyaError>
}

class NetworkManager {
    
    private static var instance = NetworkManager()
    
    public  static var shared : NetworkManager {
        return instance
    }
    
    
    private var provider = MoyaProvider<MovieAPIs>()
    
    private var anyCancellable = Set<AnyCancellable>()
        
}

extension NetworkManager : NetworkManagerProtocol {
    func fetchMovieList() -> AnyPublisher<MovieListResponseModel, MoyaError> {
        
        Future<MovieListResponseModel, MoyaError> { [weak self] promise in
            
            guard let self  else { return }
            
            self.provider.requestPublisher(.movieList, callbackQueue: .global())
                .sink ( receiveCompletion: { completion in
                    switch completion{
                    case .finished:
//                        promise(.success(MovieListResponseModel()))
                        print("Finished")
                    case .failure(let error):
                        print("error")

                        promise(.failure(error))
                    }
                }, receiveValue: { response in
                    
                    print("response = \(response.data)")
                    print("response = \(response.statusCode)")
                    print("response = \(response.response)")
                    print("response = \(response.debugDescription)")
                   guard let result = try? JSONDecoder().decode(MovieListResponseModel.self, from: response.data)
                    else {
                       promise (.failure(MoyaError.jsonMapping(response)))
                       return
                   }
                    
                    
                    promise(.success(result))
                }
            ).store(in: &anyCancellable)
            
        }.eraseToAnyPublisher()

    }
    
//    func fetchMovieDetails(movieId: String) -> AnyPublisher<MovieModel, MoyaError> {
//        //TODO:
//    }
    
    
}
