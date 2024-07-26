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
    
    @Published private(set) var movieList : [MovieModel]  = [MovieModel]()
    @Published private(set) var loadingCompleted   = false
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
            self.netwotkManager?.fetchMovieList(.movieList).sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loadingCompleted = true
                case .failure(let error):
                    print("error = \(error)")

                }
            } receiveValue: { [weak self] reponse in
                self?.movieList = reponse.results
            }.store(in: &anyCancelable)

        }
    }
}


