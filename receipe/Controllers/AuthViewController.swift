//
//  AuthViewController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 22.11.22.
//

import UIKit

class AuthViewController: UIViewController {
    
    var formView = UIView()
    var authLabel = UILabel()
    var userNameInput = UITextField()
    var passwordInput = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nil
        
        setUpFormView()
        setUpFormInputs()
        
    }
    
    func setUpFormView() {
        view.addSubview(formView)
        formView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            formView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor, multiplier: 0.6),
            formView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50)
        ])
        
        
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(authLabel)
        authLabel.text = "Login / Register"
        let font: UIFont = .systemFont(ofSize: 30, weight: .bold)
        authLabel.font = font
        
        
        NSLayoutConstraint.activate([
            authLabel.topAnchor.constraint(equalTo: formView.topAnchor, constant: 20),
            authLabel.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
        ])
        
    }
    
    func setUpFormInputs() {
        let formStack = UIStackView()
        formView.addSubview(formStack)
        formStack.translatesAutoresizingMaskIntoConstraints = false
        
        formStack.axis = .vertical
        formStack.alignment = .fill
        formStack.distribution = .fill
        formStack.spacing = 10
        
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 20),
            formStack.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            formStack.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 10),
            formStack.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: -10)
        ])
        
        [userNameInput, passwordInput].forEach {
            let padding = UIView(frame: CGRectMake(0, 0, 10, $0.frame.height))
            $0.leftView = padding
            $0.leftViewMode = .always
            $0.rightView = padding
            $0.rightViewMode = .always
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            $0.backgroundColor = .white
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemYellow.withAlphaComponent(0.5).cgColor
            $0.layer.masksToBounds = false
            $0.layer.cornerRadius = 10
            
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            
            $0.layer.shadowColor = UIColor.systemYellow.cgColor
            $0.layer.shadowOffset = CGSize.zero
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowRadius = 3.0
        }
        
        userNameInput.placeholder = "Username"
        userNameInput.textContentType = .username
        
        passwordInput.isSecureTextEntry = true
        passwordInput.textContentType = .password
        passwordInput.placeholder = "Password"
        
       
        
        formStack.addArrangedSubview(userNameInput)
        formStack.addArrangedSubview(passwordInput)
        
        
    }

}
