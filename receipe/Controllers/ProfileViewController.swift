//
//  ProfileViewController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 13.11.22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var logOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logOutButton = UIButton()
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("LogOut", for: .normal)
        logOutButton.setTitleColor(.black, for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        logOutButton.backgroundColor = K.primaryColor
        
        self.view.addSubview(logOutButton)
        
        logOutButton.widthAnchor.constraint(equalToConstant: logOutButton.intrinsicContentSize.width + 20).isActive = true

        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        
    }
    
    @objc func logOutButtonPressed(_ target: UIButton) {
        let firebaseAuth = FirebaseAuth.Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let err as NSError {
            print(err)
        }
    }
    

}
