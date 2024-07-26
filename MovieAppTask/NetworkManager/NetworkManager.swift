//
//  NetworkManager.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import Moya
import Combine


enum ErrorHandler : Error {
    
    case badGateWay
    case someThingWentWrong
    case invalidResponse
}


protocol NetworkManagerProtocol {
    
    func fetchMovieList(_ endPoint: MovieAPIs) -> AnyPublisher<MovieListResponseModel, Error>
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
    func fetchMovieList(_ endPoint: MovieAPIs) -> AnyPublisher<MovieListResponseModel, Error> {
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=7d90f9a3023dd78ccdf548ec38d982b8"//endPoint.baseURL.appendingPathComponent(endPoint.path)
       
        var request = try? URLRequest(url: url, method: .get)
        request?.addValue( appConstants.apiKey.rawValue , forHTTPHeaderField: "api_key")
        endPoint.headers?.forEach { request?.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        print("URL + \(request?.url)")
        return URLSession.shared.dataTaskPublisher(for: request!)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: MovieListResponseModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        
//        return Future<MovieListResponseModel, MoyaError> { [weak self] promise in
//            
//            guard let self  else { return }
//            self.provider.requestPublisher(.movieList).sink { completion in
//                                    switch completion{
//                                        
//                                    case .finished:
//                                        print("Finished2")
//                                    case .failure(let error):
//                                        print("error")
//                
//                                        promise(.failure(error))
//                                    }
//            } receiveValue: { response in
//                print("response = \(response.data.debugDescription)")
//                print("response = \(response.statusCode)")
//         
//            }.store(in: &anyCancellable)
//        }.eraseToAnyPublisher()

    }
    
//    func fetchMovieDetails(movieId: String) -> AnyPublisher<MovieModel, MoyaError> {
//        //TODO:
//    }
    
    
}
