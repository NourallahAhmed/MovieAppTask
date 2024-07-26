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
    
    func fetchMovieList(_ endPoint: MovieAPIs , page: Int ) -> AnyPublisher<MovieListResponseModel, Error>
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
    func fetchMovieList(_ endPoint: MovieAPIs , page: Int) -> AnyPublisher<MovieListResponseModel, Error> {
        let url = "\(appConstants.baseURL.rawValue)\(appConstants.movieListEndPoint.rawValue)?api_key=\(appConstants.apiKey.rawValue)"
//        let url = "https://api.themoviedb.org/3/discover/movie?api_key=7d90f9a3023dd78ccdf548ec38d982b8"

        var components = URLComponents(url: URL(string: url)! , resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "page", value: "\(page)"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        let request = try? URLRequest(url: components.url!)

        return URLSession.shared.dataTaskPublisher(for: request!)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: MovieListResponseModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    
    }
    
//    func fetchMovieDetails(movieId: String) -> AnyPublisher<MovieModel, MoyaError> {
//        //TODO:
//    }
    
    
}
