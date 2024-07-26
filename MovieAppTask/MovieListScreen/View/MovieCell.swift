//
//  movieCell.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import UIKit
import Kingfisher



protocol MovieCellProtocol {
    func configureMovie(movie: MovieModel?)
}

class MovieCell : UITableViewCell {
    
    private let movieImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "tv"))
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
    private let movieNameLB : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        label.textColor = .black
        label.text = "TestMovieTestMovieTestMovieTestMovieTestMovieTestMovie"
        return label
    }()
    
    
    private let movieDateLB : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        label.textColor = .black
        label.text = "1988"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView(){
        addSubview(movieImage)
        addSubview(movieNameLB)
        addSubview(movieDateLB)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieNameLB.translatesAutoresizingMaskIntoConstraints = false
        movieDateLB.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            movieImage.widthAnchor.constraint(equalToConstant: 80),
            
            movieNameLB.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieNameLB.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            movieNameLB.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor,constant: 16),
            movieNameLB.heightAnchor.constraint(equalToConstant: 45),
            
            
            movieDateLB.topAnchor.constraint(equalTo: movieNameLB.bottomAnchor, constant: 8),
            movieDateLB.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor,constant: 16),
            movieDateLB.heightAnchor.constraint(equalToConstant: 45),

            
        
        ])
    }
}

extension MovieCell : MovieCellProtocol{
    func configureMovie(movie: MovieModel?) {
        guard let movie = movie else {return }
        self.movieNameLB.text = movie.original_title
        self.movieDateLB.text = movie.release_date
        self.movieImage.kf.setImage(with: URL(string:"\(appConstants.baseURLForImages.rawValue)\(movie.poster_path!)"))
    }
}
