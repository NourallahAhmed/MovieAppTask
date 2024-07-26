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


class MovieListVC : UIViewController {
    
    private lazy var movieTV : UITableView  = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false

        // set the delegates
        table.delegate = self
        table.dataSource = self
        
        // configure the cell
        table.register( MovieCell.self , forCellReuseIdentifier: appConstants.cellIdentifier.rawValue)
        return table
    }()
    private  var cancelable: Set<AnyCancellable> = Set<AnyCancellable>() // 3

    var vm : MovieListViewModel?
    init(vm: MovieListViewModel? = nil) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        subscribeToLoading()
    }
    
    func subscribeToLoading(){
        vm?.$loadingCompleted
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] completed in
            if completed {
                self?.updateUI()
            }
            }).store(in: &cancelable)
    }
    func updateUI(){
        movieTV.reloadData()
    }
    
    func setUpTableView(){
        
        
        view.backgroundColor = .blue
        // add to view
        view.addSubview(movieTV)
        
        NSLayoutConstraint.activate([
            movieTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieTV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        
  
        
       
    }
    
    
}

extension MovieListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.movieList.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: appConstants.cellIdentifier.rawValue, for: indexPath) as? MovieCell else {

            return UITableViewCell()

        }
        
        cell.configureMovie(movie: vm?.movieList[indexPath.row])
        return cell
    }
    
    
}




struct MovieListRepresenter : UIViewControllerRepresentable {
    typealias UIViewControllerType = MovieListVC

    func updateUIViewController(_ uiViewController: MovieListVC, context: Context) {
        
    }
        
    func makeUIViewController(context: Context) -> MovieListVC {
        MovieListVC(vm: MovieListViewModel())
    }
    
    
}

#Preview{
    MovieListRepresenter()
}
