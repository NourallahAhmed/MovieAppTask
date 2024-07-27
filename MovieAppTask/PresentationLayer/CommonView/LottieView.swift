//
//  LottieView.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 28/07/2024.
//

import Foundation
import UIKit
import Lottie

class LottieView: UIView {
    
    var animationView:LottieAnimationView!
    
    
    
    required init(backgroundColor: UIColor = UIColor.white, cornerRadius: CGFloat = 0  , animationView: LottieAnimationView) {
        super.init(frame: .zero)
        super.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        
        self.animationView = animationView


       
        setupAnimationView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAnimationView() {
        
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        self.addSubview(animationView)
        animationView.bounds = self.bounds
        animationView.play()
      
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        animationView.frame = self.bounds
    }


}
