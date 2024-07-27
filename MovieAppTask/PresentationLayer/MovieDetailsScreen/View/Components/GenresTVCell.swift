//
//  GenresCollectionCell.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import UIKit



class GenresTVCell: UITableViewCell {
    
    private  var dataLB : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.numberOfLines = 3
            label.textAlignment = .natural
            label.textColor = .white
            label.text = "Family"

            return label
        }()
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = .gray.withAlphaComponent(0.6)
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor(named: "EDEDED")?.cgColor
        self.layer.borderWidth = 2.0
       
       
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    func configure(text: String){
        self.dataLB.text = text
   
    }
   
    private func setupUI(){
    
        contentView.addSubview(dataLB)
        
        NSLayoutConstraint.activate([
            dataLB.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dataLB.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    

       
}
