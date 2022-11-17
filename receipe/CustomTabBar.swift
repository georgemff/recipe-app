//
//  CustomTabBar.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 17.11.22.
//

import UIKit

class CustomTabBar: UITabBar {
    
    override func draw(_ rect: CGRect) {
        self.createPath()
        self.addMiddleButton()
        self.isTranslucent = false
        self.tintColor = .label
        self.itemPositioning = .fill
        self.unselectedItemTintColor = .systemGray
        self.tintColor = .systemYellow
        self.itemSpacing = 0
        self.itemPositioning = .centered
        clipsToBounds = false
        
        
    }
    
    func createPath() {
          
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: 0), transform: .identity)
        
        path.addQuadCurve(to: CGPoint(x: (self.frame.width / 2) - 50, y: -25), control: CGPoint(x: 0, y: 0), transform: .identity)
        
        context.addPath(path)
        context.setStrokeColor(UIColor.systemYellow.cgColor)
        context.strokePath()
       
    }

    
    func addMiddleButton() {
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .medium, scale: .default)
        
        let middleButton = UIButton()
        middleButton.frame.size = CGSize(width: self.frame.height - 15, height: self.frame.height - 15)
        
        let image = UIImage(systemName: "plus", withConfiguration: config)!
        middleButton.imageView?.contentMode = .scaleToFill
        middleButton.setImage(image, for: .normal)
        middleButton.backgroundColor =  .systemYellow
        middleButton.tintColor = .white
        middleButton.layer.cornerRadius = middleButton.frame.width / 2
        middleButton.center = CGPoint(x: self.frame.width / 2, y: (self.frame.height / 2) - 20)
        
        self.addSubview(middleButton)
    }
    
}
