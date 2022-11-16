//
//  RecipeCell.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 14.11.22.
//

import UIKit

class RecipeCell: UIView {
    
    var imageName: String?
    var title: String?
    var descriptionText: String?
    
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: String, title: String, description: String) {
        super.init(frame: .zero)
        imageName = image
        self.title = title
        descriptionText = description
        
        setUpCell()
    }
    
    private func setUpCell() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        let image = UIImage(named: imageName ?? "")
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 25
        
        let trendTitleDescView = UIView()
        trendTitleDescView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(trendTitleDescView)
        
        
        trendTitleDescView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        trendTitleDescView.topAnchor.constraint(equalTo:  self.topAnchor).isActive = true
        trendTitleDescView.trailingAnchor.constraint(equalTo:  self.trailingAnchor).isActive = true
        trendTitleDescView.bottomAnchor.constraint(equalTo:  self.bottomAnchor).isActive = true
        
        let trendTitleLabel = UILabel()
        trendTitleDescView.addSubview(trendTitleLabel)
        trendTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        trendTitleLabel.text = title
        trendTitleLabel.leadingAnchor.constraint(equalTo: trendTitleDescView.leadingAnchor).isActive = true
        trendTitleLabel.topAnchor.constraint(equalTo: trendTitleDescView.topAnchor).isActive = true
        trendTitleLabel.trailingAnchor.constraint(equalTo: trendTitleDescView.trailingAnchor).isActive = true
        
        
        
        let trendDescriptionLabel = UILabel()
        trendTitleDescView.addSubview(trendDescriptionLabel)
        trendDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        trendDescriptionLabel.text = descriptionText
        trendDescriptionLabel.font = trendDescriptionLabel.font.withSize(14)
        trendDescriptionLabel.numberOfLines = 0
        trendDescriptionLabel.leadingAnchor.constraint(equalTo: trendTitleDescView.leadingAnchor).isActive = true
        trendDescriptionLabel.topAnchor.constraint(equalTo: trendTitleLabel.bottomAnchor, constant: 10).isActive = true
        trendDescriptionLabel.trailingAnchor.constraint(equalTo: trendTitleDescView.trailingAnchor).isActive = true
        
        
    }
}
