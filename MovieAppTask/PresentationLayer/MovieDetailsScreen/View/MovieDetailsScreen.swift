//
//  MovieDetailsScreen.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import Kingfisher

class MovieDetailsScreen : BaseViewController {

    
    private var vm : MovieDetailsViewModel
    
    private lazy var movieImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "tv"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .black.withAlphaComponent(0.1)
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
    private lazy var movieNameLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Movie Name title"

        return label
    }()
    
    private lazy var movieDescLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .white
        label.text = "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone"
        return label
    }()
    private lazy var movieOverViewLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .white
        label.text = "Overview"
        return label
    }()
    private lazy var genersLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .white
        label.text = "Geners"
        return label
    }()
    
    private lazy var budgetTitleLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .white
        label.text = "Budget"
        return label
    }()
    private lazy var budgetLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .white
        label.text = "Geners"
        return label
    }() 
    
    
    private lazy var revenueTitleLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .white
        label.text = "Revenue"
        return label
    }()
    private lazy var revenueLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .white
        label.text = "Geners"
        return label
    }()
    
    private lazy var websiteIcon : UIButton = {
        let button = UIButton()
         button.setImage(UIImage(named: "link")?.withTintColor(.darkGray), for: .normal)
        return button
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.isScrollEnabled = true
        scrollView.delaysContentTouches = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    private lazy var genresTV : UITableView  = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.isPagingEnabled = true
        // set the delegates
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        // configure the cell
        table.register( GenresTVCell.self , forCellReuseIdentifier: appConstants.genresCelldentifier.rawValue)
        return table
    }()
    
    
    
    private lazy var progressBar: CircleProgress = {
        let progress = CircleProgress()
        progress.lineWidth = 3
        progress.trackColor = .lightGray.withAlphaComponent(0.2)
        progress.progressColor = .green
        progress.strokeEnd  = 60
        progress.inset = 3
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    private  var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()

    
    init(vm: MovieDetailsViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black
        setupScrollView()
        setupView()
        subscribeToLoading()
        
        
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
  
    func subscribeToLoading(){
        vm.$isLoadingCompleted
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] completed in
            if completed {
                self?.updateUI()
            }
            }).store(in: &cancelable)
    }
    func updateUI(){
        genresTV.reloadData()
        movieNameLB.text = vm.movie?.original_title
        budgetLB.text =  "\(vm.movie?.budget?.description ?? "_") $"
        revenueLB.text =  "\(vm.movie?.revenue?.description ?? "_") $"
        movieDescLB.text = vm.movie?.overview
        movieImage.kf.setImage(with: URL(string:"\(appConstants.baseURLForImages.rawValue)\(vm.movie!.poster_path!)"))
        progressBar.strokeEnd = CGFloat((vm.movie?.vote_average ?? 0.0) / 100)
        progressBar.lineWidth = 3
        progressBar.progressLB.text =  String(format: "%.2f%%", (vm.movie?.vote_average ?? 0))
        
        
        progressBar.progressLB.textColor  =  .white
        progressBar.progressColor = .green

    }
    func setupScrollView(){
        
        scrollView.contentSize = CGSize(width: view.bounds.size.width , height: view.bounds.size.height )
        scrollView.delegate = self
    }
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(movieImage)
        scrollView.addSubview(progressBar)
        scrollView.addSubview(movieNameLB)
        scrollView.addSubview(movieOverViewLB)
        scrollView.addSubview(movieDescLB)
        scrollView.addSubview(genersLB)
        scrollView.addSubview(genresTV)
        scrollView.addSubview(budgetTitleLB)
        scrollView.addSubview(budgetLB)
        scrollView.addSubview(revenueTitleLB)
        scrollView.addSubview(revenueLB)
        
        
        
        NSLayoutConstraint.activate([
            
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                        
            
            movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor , constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor , constant: 12),
            movieImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            movieImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  - 20),
            
            
            
            
            progressBar.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor , constant: -8),
            progressBar.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor , constant: -10),
            progressBar.heightAnchor.constraint(equalToConstant: 60),
            progressBar.widthAnchor.constraint(equalToConstant: 60),
           
            
            movieNameLB.topAnchor.constraint(equalTo: movieImage.bottomAnchor , constant: 16),
            movieNameLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            
            
            movieOverViewLB.topAnchor.constraint(equalTo: movieNameLB.bottomAnchor , constant: 16),
            movieOverViewLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            
            movieDescLB.topAnchor.constraint(equalTo: movieOverViewLB.bottomAnchor, constant: 16),
            movieDescLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            movieDescLB.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor , constant: -8),

            
            
            
            genersLB.topAnchor.constraint(equalTo: movieDescLB.bottomAnchor , constant: 16),
            genersLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            
            genresTV.topAnchor.constraint(equalTo: genersLB.bottomAnchor , constant:  16),
            genresTV.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            genresTV.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor , constant: -8),
            genresTV.heightAnchor.constraint(equalToConstant: 80),
            
            budgetTitleLB.topAnchor.constraint(equalTo: genresTV.bottomAnchor , constant: 16),
            budgetTitleLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            
            budgetTitleLB.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            
            budgetLB.topAnchor.constraint(equalTo: budgetTitleLB.bottomAnchor , constant: 16),
            
            
            budgetLB.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            budgetLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            
            
            
            revenueTitleLB.topAnchor.constraint(equalTo: budgetTitleLB.topAnchor , constant: 0),
            revenueTitleLB.leadingAnchor.constraint(equalTo: budgetTitleLB.trailingAnchor , constant: 8),
            
   
            revenueLB.topAnchor.constraint(equalTo: revenueTitleLB.bottomAnchor , constant: 16),
            revenueLB.leadingAnchor.constraint(equalTo: budgetLB.trailingAnchor , constant: 8),
            
   
            
        ])
    }
    
}
extension MovieDetailsScreen : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Get the content offset of the scroll view
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        scrollView.contentInset = contentInset
        
    }
}
extension MovieDetailsScreen : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movie?.genre_ids?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: appConstants.genresCelldentifier.rawValue, for: indexPath) as? GenresTVCell else {
            return UITableViewCell()
        }
        cell.configure(text: vm.movie?.genre_ids?[indexPath.row].name ?? "")
        return cell
    }
    
    
    
}


struct MovieDetailsRepresenter : UIViewControllerRepresentable {
    typealias UIViewControllerType = MovieDetailsScreen

    func updateUIViewController(_ uiViewController: MovieDetailsScreen, context: Context) {
        
    }
        
    func makeUIViewController(context: Context) -> MovieDetailsScreen {
        MovieDetailsScreen(vm:
                            MovieDetailsViewModel(
                                movieID: 1022789 ,
                                fetchMovieUseCase: FetchMovieDetailsUseCase<AnyPublisher<MovieModel, Error>>() ))
    }
    
    
}

#Preview{
    MovieDetailsRepresenter()
}

