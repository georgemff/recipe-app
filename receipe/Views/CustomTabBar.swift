//
//  CustomTabBar.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 17.11.22.
//

import UIKit

class CustomTabBar: UITabBar {
    
    var didTapButton: (() -> ())?
    var middleButton: UIButton!
    
    
    override func draw(_ rect: CGRect) {
        
        self.addMiddleButton()
//        self.addTopBorder()
        //        self.createPath()
    }
    
    func addTopBorder() {
        let thickness: CGFloat = 2.0
        let topBorder = CALayer()
        
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: thickness)
        topBorder.backgroundColor = UIColor.gray.cgColor
        topBorder.opacity = 0.5
        
        self.layer.addSublayer(topBorder)
    }
    
    
    func createPath() {
        
        let path = UIBezierPath()
        UIColor.white.setFill()
        path.fill()
        
        let middleButtonWidth = middleButton.frame.width
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: (self.frame.width / 2) - (middleButtonWidth / 2) - 20, y: 0))
        
        path.addArc(withCenter: CGPoint(x: (self.frame.width / 2) - 60, y: -20), radius: 20, startAngle: .pi / 2, endAngle: (.pi) / 7, clockwise: false)
        path.addArc(withCenter: CGPoint(x: (self.frame.width / 2), y: 25), radius: middleButtonWidth / 2 + 21, startAngle: (5 * .pi) / 4, endAngle: (7 * .pi) / 4 , clockwise: true)
        path.addArc(withCenter: CGPoint(x: (self.frame.width / 2) + 60, y: -20), radius: 20, startAngle: (5 * .pi) / 6, endAngle: .pi / 2 , clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        //        shapeLayer.backgroundColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.systemYellow.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = 5
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3
        shapeLayer.shadowRadius = 7
        shapeLayer.shadowOffset = CGSize(width: 0, height: -5)
        
        self.layer.addSublayer(shapeLayer)
        self.layer.backgroundColor = UIColor.white.cgColor
        
        
    }
    
    
    func addMiddleButton() {
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .medium, scale: .default)
        
        middleButton = UIButton()
        
        let buttonSize = self.frame.height > 80 ? self.frame.height - 30: self.frame.height
        middleButton.frame.size = CGSize(width: buttonSize, height: buttonSize)
        
        let image = UIImage(systemName: "plus", withConfiguration: config)!
        middleButton.imageView?.contentMode = .scaleToFill
        middleButton.setImage(image, for: .normal)
        middleButton.backgroundColor =  K.primaryColor
        middleButton.tintColor = .white
        middleButton.layer.cornerRadius = middleButton.frame.width / 2
        middleButton.center = CGPoint(x: self.frame.width / 2, y: middleButton.frame.height - (middleButton.frame.height / 2) - 3)
        middleButton.addTarget(self, action: #selector(middleButtonPressed), for: .touchUpInside)
        self.addSubview(middleButton)
    }
    
    @objc func middleButtonPressed(_ sender: UIButton) {
        self.didTapButton?()
    }
    
    private func radian(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
            
            return self.middleButton.frame.contains(point) ? self.middleButton : super.hitTest(point, with: event)
        }
    
}
