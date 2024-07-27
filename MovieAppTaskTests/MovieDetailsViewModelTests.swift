//
//  MoveDetailsViewModelTests.swift
//  MovieAppTaskTests
//
//  Created by NourAllah Ahmed on 28/07/2024.
//

import XCTest
import Combine
import Moya
@testable import MovieAppTask

final class MovieDetailsViewModelTests: XCTestCase {
    var vm : MockMovieDetailsViewModel!
    override  func setUp() {
        vm = MockMovieDetailsViewModel(movieID: 1022709, fetchMovieUseCase: FetchMovieDetailsUseCase<AnyPublisher<MovieModel, Error>>())
        super.setUp()
    }

    override  func tearDown() {
        super.tearDown()
        vm = nil
    }
    
    func testMovieDetails(){
        XCTAssertNotNil(vm.movie)
    }
}
