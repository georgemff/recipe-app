//
//  Trends.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 16.11.22.
//

import UIKit

class Trends: UIView {

    var imageName: String?
    var trendTitle: String?
    var complexityLabel: String?
    var review: String?
    var duration: String?
    var complexity: String?
    
    override init(frame: CGRect) {
        fatalError("init(frame:) is not implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    init(imageName: String, trendTitle: String, complexityLabel: String, review: String, duration: String, complexity: String) {
        super.init(frame: .zero)
        
        self.imageName = imageName
        self.trendTitle = trendTitle
        self.complexityLabel = complexityLabel
        self.review = review
        self.duration = duration
        self.complexity = complexity
        
        self.setUpUI()
    }
    
    private func setUpUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: self.imageName!)
        let imageView = UIImageView(image: image)
        
        self.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
        let trendDetails = UIView()
        
        self.addSubview(trendDetails)
        trendDetails.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trendDetails.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 30),
            trendDetails.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            trendDetails.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            trendDetails.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])

        
        trendDetails.layer.cornerRadius = 20
        trendDetails.layer.masksToBounds = false
        trendDetails.layer.shadowColor = UIColor.systemGray.cgColor
        trendDetails.layer.shadowOpacity = 0.5
        trendDetails.layer.shadowOffset = CGSize(width: 0, height: 0)
        trendDetails.layer.shadowRadius = 10
        
        let bgColor = trendDetails.backgroundColor?.cgColor
        trendDetails.backgroundColor = nil
        trendDetails.layer.backgroundColor = bgColor
        
        
        //Blur
        let blurBg = UIView()
        trendDetails.addSubview(blurBg)
        blurBg.translatesAutoresizingMaskIntoConstraints = false
        blurBg.backgroundColor = .white
        blurBg.frame = trendDetails.bounds
        blurBg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurBg.alpha = 0.7
        blurBg.layer.cornerRadius = 20
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        trendDetails.addSubview(blurEffectView)
        
        
        let trendDetailsTopStack = UIStackView()
        trendDetails.addSubview(trendDetailsTopStack)
        trendDetailsTopStack.translatesAutoresizingMaskIntoConstraints = false
        trendDetailsTopStack.distribution = .fill
        trendDetailsTopStack.axis = .vertical
        trendDetailsTopStack.alignment = .fill
        trendDetailsTopStack.spacing = 0
        
        NSLayoutConstraint.activate([
            trendDetailsTopStack.leadingAnchor.constraint(equalTo: trendDetails.leadingAnchor, constant: 20),
            trendDetailsTopStack.topAnchor.constraint(equalTo: trendDetails.topAnchor, constant: 10),
            trendDetailsTopStack.trailingAnchor.constraint(equalTo: trendDetails.trailingAnchor, constant:  -20),
        ])
        
        let trendTitleLabel = UILabel()
        trendTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        trendTitleLabel.text = self.trendTitle!
        trendTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        trendDetailsTopStack.addArrangedSubview(trendTitleLabel)
        
        let trendStatusLabel = UILabel()
        trendStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        trendStatusLabel.text = self.complexityLabel!
        trendStatusLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        trendDetailsTopStack.addArrangedSubview(trendStatusLabel)
        
        let divider = UIView()
        trendDetails.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .systemGray
        divider.alpha = 0.5
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: trendDetailsTopStack.bottomAnchor, constant: 5),
            divider.leadingAnchor.constraint(equalTo: trendDetails.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: trendDetails.trailingAnchor, constant: -20)
        ])
        
        let trendIconsStack = UIStackView()
        trendDetails.addSubview(trendIconsStack)
        trendIconsStack.translatesAutoresizingMaskIntoConstraints = false
        trendIconsStack.distribution = .fillEqually
        trendIconsStack.axis = .horizontal
        trendIconsStack.alignment = .center
        
        NSLayoutConstraint.activate([
            trendIconsStack.leadingAnchor.constraint(equalTo: trendDetails.leadingAnchor, constant: 20),
            trendIconsStack.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 10),
            trendIconsStack.trailingAnchor.constraint(equalTo: trendDetails.trailingAnchor, constant:  -20),
        ])
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .medium, scale: .default)
        
        let reviewIconImage = UIImage(systemName: "star.fill", withConfiguration: config)
        let reviewIconImageView = UIImageView(image: reviewIconImage)
        reviewIconImageView.translatesAutoresizingMaskIntoConstraints = false
        reviewIconImageView.tintColor = .systemYellow
        
        let reviewView = UIView()
        reviewView.addSubview(reviewIconImageView)
        NSLayoutConstraint.activate([
            reviewIconImageView.leadingAnchor.constraint(equalTo: reviewView.leadingAnchor),
            reviewIconImageView.topAnchor.constraint(equalTo: reviewView.topAnchor),
            reviewIconImageView.bottomAnchor.constraint(equalTo: reviewView.bottomAnchor)
            
        ])
        let reviewLabel = UILabel()
        reviewLabel.text = self.review!
        reviewView.addSubview(reviewLabel)
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewLabel.leadingAnchor.constraint(equalTo: reviewIconImageView.trailingAnchor, constant: 5),
            reviewLabel.topAnchor.constraint(equalTo: reviewView.topAnchor),
            reviewLabel.bottomAnchor.constraint(equalTo: reviewView.bottomAnchor)
        ])
        trendIconsStack.addArrangedSubview(reviewView)
        
        
        
        let clockIconImage = UIImage(systemName: "clock", withConfiguration: config)
        let clockIconImageView = UIImageView(image: clockIconImage)
        clockIconImageView.translatesAutoresizingMaskIntoConstraints = false
        clockIconImageView.tintColor = .systemBlue
        
        let clockView = UIView()
        clockView.addSubview(clockIconImageView)
        NSLayoutConstraint.activate([
            clockIconImageView.leadingAnchor.constraint(equalTo: clockView.leadingAnchor),
            clockIconImageView.topAnchor.constraint(equalTo: clockView.topAnchor),
            clockIconImageView.bottomAnchor.constraint(equalTo: clockView.bottomAnchor)
            
        ])
        let clockLabel = UILabel()
        clockLabel.text = self.duration!
        clockView.addSubview(clockLabel)
        clockLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clockLabel.leadingAnchor.constraint(equalTo: clockIconImageView.trailingAnchor, constant: 5),
            clockLabel.topAnchor.constraint(equalTo: clockView.topAnchor),
            clockLabel.bottomAnchor.constraint(equalTo: clockView.bottomAnchor)
        ])
        
        trendIconsStack.addArrangedSubview(clockView)
        
        
        
        
        let foodIconImage = UIImage(systemName: "takeoutbag.and.cup.and.straw", withConfiguration: config)
        let foodIconImageView = UIImageView(image: foodIconImage)
        foodIconImageView.translatesAutoresizingMaskIntoConstraints = false
        foodIconImageView.tintColor = .systemPink
        
        let foodView = UIView()
        foodView.addSubview(foodIconImageView)
        NSLayoutConstraint.activate([
            foodIconImageView.leadingAnchor.constraint(equalTo: foodView.leadingAnchor),
            foodIconImageView.topAnchor.constraint(equalTo: foodView.topAnchor),
            foodIconImageView.bottomAnchor.constraint(equalTo: foodView.bottomAnchor)
            
        ])
        let foodLabel = UILabel()
        foodLabel.text = self.complexity!
        foodView.addSubview(foodLabel)
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodLabel.leadingAnchor.constraint(equalTo: foodIconImageView.trailingAnchor, constant: 5),
            foodLabel.topAnchor.constraint(equalTo: foodView.topAnchor),
            foodLabel.bottomAnchor.constraint(equalTo: foodView.bottomAnchor)
        ])
        
        trendIconsStack.addArrangedSubview(foodView)
    }

}
