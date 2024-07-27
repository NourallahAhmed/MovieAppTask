//
//  MovieListVC.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import Moya

class MovieListVC : BaseViewController {
    private var spinner = UIActivityIndicatorView(style: .large)

    private lazy var movieTV : UITableView  = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        
        // set the delegates
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        // configure the cell
        table.register( MovieCell.self , forCellReuseIdentifier: appConstants.movieListCellIdentifier.rawValue)
        return table
    }()
    
    
    private  var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()

    var vm : MovieListViewModel
    
    init(vm: MovieListViewModel){
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpView()
        
        subscribeToError()
        subscribeToLoading()
        
    }
    
    func subscribeToError(){
        vm.$error.receive(on: DispatchQueue.main)
            .sink { error in
                if !error.isEmpty {
                    Alert.shared.showErrorMessage(title: "Error", body: error)
                }
            }.store(in: &cancelable)
    }
    
    func subscribeToLoading(){

        vm.$loadingCompleted
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] completed in
                print("completed == \(completed)")
            if completed {
                self?.updateUI()
            }else{
                self?.spinner.startAnimating()

            }
            }).store(in: &cancelable)
    }
    
    func updateUI() {
        self.spinner.stopAnimating()
        self.movieTV.reloadData()

        
    }
    
    func setUpView(){
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .orange
        view.addSubview(movieTV)
        view.addSubview(spinner)

        
        NSLayoutConstraint.activate([
            movieTV.topAnchor.constraint(equalTo: view.topAnchor),
            movieTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
               
    }
    
    
}

extension MovieListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count \(vm.movieList.count)")
        return vm.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: appConstants.movieListCellIdentifier.rawValue, for: indexPath) as? MovieCell else {

            return UITableViewCell()

        }
        cell.configureMovie(movie: vm.movieList[indexPath.row])
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(
            MovieDetailsScreen(
                vm: MovieDetailsViewModel(
                    movieID:vm.movieList[indexPath.row].id ?? 1022789, fetchMovieUseCase: FetchMovieDetailsUseCase<AnyPublisher<MovieModel , Error>>())),
                            animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            if vm.hasMoreData == true && vm.loadingCompleted == true {
                addTableViewFooter(tableView: self.movieTV)
                vm.fetchMovies()
            }
        }
    }    
 
    
}

struct MovieListRepresenter : UIViewControllerRepresentable {
    typealias UIViewControllerType = MovieListVC

    func updateUIViewController(_ uiViewController: MovieListVC, context: Context) {
        
    }
        
    func makeUIViewController(context: Context) -> MovieListVC {
        MovieListVC(vm: MovieListViewModel(fetchMoviesUseCase: FetchMoviesUseCase<AnyPublisher<MovieListResponseModel , MoyaError>>()))
    }
    
    
}

#Preview{
    MovieListRepresenter()
}
