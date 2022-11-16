//
//  AuthorizationButton.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 14.11.22.
//

import UIKit

class AuthorizationButton: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpUI()
    }
    
    private func setUpUI() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login / Register"
        label.textColor = .white
        label.textAlignment = .center
        
        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }

}
