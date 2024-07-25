//
//  MovieListViewModel.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import Combine
import Moya

protocol MovieListViewModelProtocol {
    func fetchMovies()
}


class MovieListViewModel : MovieListViewModelProtocol {
    
    @Published var movieList : [Movie]  = [Movie]()
    private var netwotkManager : NetworkManagerProtocol?
    private var anyCancelable = Set<AnyCancellable>()
    
    
    
    ///for testing purpose
    init(networkClient : NetworkManagerProtocol = NetworkManager.shared ) {
        self.netwotkManager = networkClient
        self.fetchMovies()
    }
    
    
    func fetchMovies() {
        DispatchQueue.global().async { [weak self] in
            guard let  self = self else { return}
            self.netwotkManager?.fetchMovieList().sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("error = \(error)")

                }
            } receiveValue: { reponse in
                self.movieList = reponse.results
                print("movieList= \(reponse)")
            }.store(in: &anyCancelable)

        }
    }
}
