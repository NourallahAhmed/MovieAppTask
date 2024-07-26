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
    @Published private(set) var hasMoreData   = false
    private var nextPage = 1
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
            self.netwotkManager?.fetchMovieList(.movieList , page: nextPage).sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loadingCompleted = true
                case .failure(let error):
                    print("error = \(error)")

                }
            } receiveValue: { [weak self] response in
                if response.page < response.totalPages {
                    self?.hasMoreData = true
                    self?.nextPage = response.page + 1
                }
                self?.movieList.append(contentsOf: response.results )
                
                
            }.store(in: &anyCancelable)

        }
    }
}


