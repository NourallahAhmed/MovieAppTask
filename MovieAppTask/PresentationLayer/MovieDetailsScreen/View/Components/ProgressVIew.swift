//
//  ProgressVIew.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 27/07/2024.
//


import Foundation
import UIKit

public class CircleProgress: UIView {
    public var lineWidth: CGFloat = 5              { didSet { updatePath() } }
    public var strokeEnd: CGFloat = 1              { didSet { progressLayer.strokeEnd = strokeEnd } }
    
    public var trackColor: UIColor = .black        { didSet { trackLayer.strokeColor = trackColor.cgColor } }
    
    public var progressColor: UIColor = .red       { didSet { progressLayer.strokeColor = progressColor.cgColor } }
    
    public var inset: CGFloat = 0                  { didSet { updatePath() } }
    
     lazy var progressLB : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 3
        label.textAlignment = .natural
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.text = "10"

        return label
    }()

    private lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = trackColor.cgColor
        layer.lineWidth = lineWidth
        return layer
    }()
    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = progressColor.cgColor
        layer.lineWidth = lineWidth
        return layer
    }()
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
}
private extension CircleProgress {
    func setupView() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
        progressLB.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLB)
        
        NSLayoutConstraint.activate([
            progressLB.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressLB.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    func updatePath() {
        let rect = bounds.insetBy(dx: lineWidth / 2 + inset, dy: lineWidth / 2 + inset)
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let path = UIBezierPath(arcCenter: centre,
                                radius: radius,
                                startAngle: -.pi / 2,
                                endAngle: 3 * .pi / 2,
                                clockwise: true)
        trackLayer.path = path.cgPath
        trackLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.lineWidth = lineWidth
    }
}
