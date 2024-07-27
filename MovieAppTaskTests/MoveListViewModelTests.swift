//
//  MoveListViewModelTests.swift
//  MovieAppTaskTests
//
//  Created by NourAllah Ahmed on 28/07/2024.
//

import XCTest
import Combine
import Moya
@testable import MovieAppTask
final class MoveListViewModelTests: XCTestCase {
    
    
    
    var vm  : MockMovieListViewModel!

    override  func setUp() {
        vm =  MockMovieListViewModel(fetchMoviesUseCase: FetchMoviesUseCase<AnyPublisher<MovieListResponseModel, MoyaError>>())
        super.setUp()

    }
    
    
    override  func tearDown() {
        vm = nil
        super.tearDown()
    }
    func testFetchMovies(){
        //since we call it in the init of vm
        XCTAssertNotNil(vm.movieList)
        XCTAssertEqual(vm.movieList.count, 2)
        
    }
}
