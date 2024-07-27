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
    @Published private(set) var error   = ""
    @Published private(set) var hasMoreData   = false
    private var nextPage = 1
    private var fetchMovieListUseCase : FetchMoviesUseCase<AnyPublisher<MovieListResponseModel, MoyaError>>

    private var anyCancelable = Set<AnyCancellable>()
    
    
    
    ///for testing purpose
    init(fetchMoviesUseCase: FetchMoviesUseCase<AnyPublisher<MovieListResponseModel, MoyaError>>) {
        self.fetchMovieListUseCase = fetchMoviesUseCase
        self.fetchMovies()
    }
    
    
    func fetchMovies() {
        DispatchQueue.global().async { [weak self] in
            guard let  self = self else { return}
                self.fetchMovieListUseCase.execute(input: nextPage, networkManager: NetworkManager.shared).sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loadingCompleted = true
                case .failure(let error):
                    
                    
                    self?.error = error.localizedDescription
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


