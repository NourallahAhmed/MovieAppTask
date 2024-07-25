//
//  MovieListVC.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import UIKit


class MovieListVC : UIViewController {
    
    private var movieTV : UITableView  = {
        
        let table = UITableView()
        return table
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    func configureTableView(){
        
        
        view.backgroundColor = .blue
        // add to view
        view.addSubview(movieTV)
        
        movieTV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieTV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        // set the delegates
        movieTV.delegate = self
        movieTV.dataSource = self
        
        // configure the cell
        movieTV.register( MovieCell.self , forCellReuseIdentifier: appConstants.cellIdentifier.rawValue)
        movieTV.reloadData()
    }
    
    
}

extension MovieListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: appConstants.cellIdentifier.rawValue, for: indexPath) as? MovieCell else {
            print("UITableViewCell")
            return UITableViewCell()

        }
        print("Cell")

        
        return cell
    }
    
    
}
