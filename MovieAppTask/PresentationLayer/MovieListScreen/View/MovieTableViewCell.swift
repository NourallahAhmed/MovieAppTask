//
//  movieCell.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import UIKit
import Kingfisher
import SkeletonView


protocol MovieCellProtocol {
    func configureMovie(movie: MovieModel?)
}

class MovieCell : UITableViewCell {
    
    private let movieImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "tv"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
        
    }()
    
    private let movieNameLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        label.textColor = .white
        label.isSkeletonable = true
        label.skeletonLineSpacing = 2
        label.text = "####################"
        return label
    }()
    
    private let movieDateLB : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        label.textColor = .white
        label.isSkeletonable = true
        label.skeletonLineSpacing = 1
        label.text = "1988"
        return label
    }()
    
    private let customBackgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.backgroundColor = .lightGray.withAlphaComponent(0.8)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.isSkeletonable = true
        backgroundView?.isSkeletonable = true
        setUpView()

    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView(){
        contentView.addSubview(customBackgroundView)

        customBackgroundView.addSubview(movieImage)
        customBackgroundView.addSubview(movieNameLB)
        customBackgroundView.addSubview(movieDateLB)
       
        NSLayoutConstraint.activate([
            
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor , constant:  28),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor , constant:  28),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor , constant:  -28),
            customBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant:  -16),
            
            
            movieImage.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 16),
            movieImage.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -16),
            movieImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3),
            
            movieNameLB.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 16),
            movieNameLB.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor,constant: -16),
            movieNameLB.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor,constant: 16),
            movieNameLB.heightAnchor.constraint(equalToConstant: 20),
            
            
            movieDateLB.topAnchor.constraint(equalTo: movieNameLB.bottomAnchor, constant: 8),
            movieDateLB.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor,constant: 16),
            movieDateLB.heightAnchor.constraint(equalToConstant: 20),
        
        ])
    }
}

extension MovieCell : MovieCellProtocol{
    func configureMovie(movie: MovieModel?) {
        self.contentView.hideSkeleton()
        guard let movie = movie else {return }
        self.movieNameLB.text = movie.original_title
        self.movieDateLB.text = movie.release_date
        self.movieImage.kf.setImage(with: URL(string:"\(appConstants.baseURLForImages.rawValue)\(movie.poster_path!)"))
    }
}
