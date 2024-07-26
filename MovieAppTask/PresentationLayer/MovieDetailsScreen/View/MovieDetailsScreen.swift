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
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 3
        label.textAlignment = .natural
        label.textColor = .black
        label.text = "Movie Name title"

        return label
    }()
    
    private lazy var movieDescLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.textColor = .black
        label.text = "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone"
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
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        scrollView.delaysContentTouches = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    
    private lazy var genresCollectionView : UICollectionView = {
       let layout = UICollectionViewLayout()
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       collectionView.isScrollEnabled = true
       collectionView.allowsMultipleSelection = false
       collectionView.allowsSelection = false
       collectionView.delegate = self
       collectionView.dataSource = self
       collectionView.backgroundColor = .lightGray
       collectionView.register(GenresCollectionCell.self, forCellWithReuseIdentifier: appConstants.genresCelldentifier.rawValue)
       return collectionView
    }()
    
    private  var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()

    
    init(vm: MovieDetailsViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)

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
        genresCollectionView.reloadData()
        movieNameLB.text = vm.movie?.original_title
        movieDescLB.text = vm.movie?.overview
        movieImage.kf.setImage(with: URL(string:"\(appConstants.baseURLForImages.rawValue)\(vm.movie!.poster_path!)"))

    }
    func setupScrollView(){
        
        scrollView.contentSize = CGSize(width: view.bounds.size.width , height: view.bounds.size.height )
        scrollView.delegate = self
    }
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(movieImage)
        scrollView.addSubview(movieNameLB)
        scrollView.addSubview(movieDescLB)
        scrollView.addSubview(genresCollectionView)
        
        
        
        NSLayoutConstraint.activate([
            
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                        
            
            movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor , constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor , constant: 12),
            movieImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            movieImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  - 20),
            
            
            movieNameLB.topAnchor.constraint(equalTo: movieImage.bottomAnchor , constant: 8),
            movieNameLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            
            movieDescLB.topAnchor.constraint(equalTo: movieNameLB.bottomAnchor, constant: 8),
            movieDescLB.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            movieDescLB.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor , constant: -8),

            genresCollectionView.topAnchor.constraint(equalTo: movieDescLB.bottomAnchor , constant:  8),
            genresCollectionView.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor , constant: 8),
            genresCollectionView.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor , constant: -8),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
   
            
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

extension MovieDetailsScreen : UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appConstants.genresCelldentifier.rawValue, for: indexPath) as? GenresCollectionCell else {
            print("else")
            return UICollectionViewCell()
        }
        print("cell")
        cell.configure(text: "Hellllo iam herreee")
        return cell
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (collectionView.frame.size.width/2) - 5, height: 75);
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
//    }
    
}
struct MovieDetailsRepresenter : UIViewControllerRepresentable {
    typealias UIViewControllerType = MovieDetailsScreen

    func updateUIViewController(_ uiViewController: MovieDetailsScreen, context: Context) {
        
    }
        
    func makeUIViewController(context: Context) -> MovieDetailsScreen {
        MovieDetailsScreen(vm: MovieDetailsViewModel(movieID: 1022789 ))
    }
    
    
}

#Preview{
    MovieDetailsRepresenter()
}

