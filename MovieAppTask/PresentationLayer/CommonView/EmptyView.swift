//
//  EmptyView.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 28/07/2024.
//

import Foundation
import UIKit
import Lottie

class CustomEmptyView: UIView {

    var imageView  : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "tv"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .black.withAlphaComponent(0.1)
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    var lottieView = LottieView(backgroundColor: .clear, cornerRadius: 0, animationView: LottieAnimationView(name: "no data"))
    
    private lazy var titleLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .white
        label.text = "No Data Found"

        return label
    }()
   
    
    init(image: String , isImage: Bool , titleText: String) {
        super.init(frame: .zero)


    
        titleLB.text = titleText
        if isImage == false {
            lottieView = LottieView(backgroundColor: .clear, cornerRadius: 0, animationView: LottieAnimationView(name: image))
            lottieView.backgroundColor = .clear
            lottieView.animationView.play()
            imageView.isHidden = true
            self.bringSubviewToFront(lottieView)
        }else{
            imageView.image = UIImage(named: image)
            imageView.contentMode = .scaleAspectFit
            lottieView.isHidden = true
        }
        
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        addSubview(imageView)
        addSubview(titleLB)
        addSubview(lottieView)
        
        centerStack()
    }
    
    func centerStack() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        titleLB.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: titleLB.topAnchor , constant: -50),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),

            lottieView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lottieView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lottieView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.4),
            lottieView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),
            
            titleLB.topAnchor.constraint(equalTo: lottieView.bottomAnchor),
            titleLB.heightAnchor.constraint(equalToConstant: 50),
            titleLB.centerXAnchor.constraint(equalTo: centerXAnchor),


        ])
    }
}
