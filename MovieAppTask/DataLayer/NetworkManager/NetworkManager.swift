//
//  NetworkManager.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import Combine
import Moya


protocol MovieListNetworkManagerProtocol {
    
      func fetchMovieList(_ endPoint: MovieAPIs) -> AnyPublisher<MovieListResponseModel, MoyaError>
}
protocol MovieDetailsNetworkManagerProtocol {
     func fetchMovieDetails(_ endPoint: MovieAPIs) -> AnyPublisher<MovieModel , MoyaError>

}



class NetworkManager {
    
    private static var instance = NetworkManager(provider: MoyaProvider<MovieAPIs>())
    
    public  static var shared : NetworkManager {
        return instance
    }
    private var anyCancellable = Set<AnyCancellable>()
    private var provider  : MoyaProvider<MovieAPIs>
    init( provider: MoyaProvider<MovieAPIs>) {
        self.provider = provider
    }
        
}

extension NetworkManager : MovieListNetworkManagerProtocol {
    open func fetchMovieList(_ endPoint: MovieAPIs) -> AnyPublisher<MovieListResponseModel, MoyaError> {

    return Future<MovieListResponseModel, MoyaError> { [weak self] promise in
            
            guard let self  else { return }
            self.provider.requestPublisher(endPoint)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .map(\.data)
                .sink ( receiveCompletion: { completion in
                    switch completion{
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        
                        promise(.failure(error))
                    }
                },
                        receiveValue: { response in
                    
                    print("response = \(response)")
                    guard let result = try? JSONDecoder().decode(MovieListResponseModel.self, from: response)
                    else {
                        // promise (.failure(MoyaError.jsonMapping(response)))
                        return
                    }
                    
                    
                    promise(.success(result))
                }
                ).store(in: &anyCancellable)
        
        }.eraseToAnyPublisher()

    }
        
    
}
extension NetworkManager : MovieDetailsNetworkManagerProtocol {
     open func fetchMovieDetails(_ endPoint: MovieAPIs) -> AnyPublisher<MovieModel, MoyaError> {
        return Future<MovieModel, MoyaError> { [weak self] promise in
                
                guard let self  else { return }
                    self.provider.requestPublisher(endPoint)
                        .subscribe(on: DispatchQueue.global(qos: .background))
                        .map(\.data)
                        .sink ( receiveCompletion: { completion in
                            switch completion{
                            case .finished:
                                print("Finished")
                            case .failure(let error):
                                print("error")
                                
                                promise(.failure(error))
                            }
                        },receiveValue: { response in
                            
                            print("response = \(response)")
                            guard let result = try? JSONDecoder().decode(MovieModel.self, from: response)
                            else {
                                //promise (.failure(MoyaError.jsonMapping(response)))
                                return
                            }
                            promise(.success(result))
                        }
                        ).store(in: &anyCancellable)
            }.eraseToAnyPublisher()

    }
}
