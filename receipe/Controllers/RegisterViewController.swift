//
//  RegisterViewController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 23.11.22.
//

import UIKit

class RegisterViewController: UIViewController {
    var formView: UIView!
    var formStack: UIStackView!
    var authLabel: UILabel!
    var userNameInput: UITextField!
    var passwordInput: UITextField!
    var confirmPasswordInput: UITextField!
    var loginButton: UIButton!
    var registerButton: UIButton!
    
    var dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpUI()
        
    }
    
    func setUpUI() {
       
            setUpFormView()
            setUpForm()
            setUpRegisterButton()
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }

}

extension RegisterViewController {
    func setUpFormView() {
        formView = UIView()
        self.view.addSubview(formView)
        formView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            formView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor, multiplier: 0.6),
            formView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50)
        ])
        
        authLabel = UILabel()
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(authLabel)
        authLabel.text = "Register"
        let font: UIFont = .systemFont(ofSize: 30, weight: .bold)
        authLabel.font = font
        
        
        NSLayoutConstraint.activate([
            authLabel.topAnchor.constraint(equalTo: formView.topAnchor, constant: 20),
            authLabel.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            authLabel.heightAnchor.constraint(equalToConstant: authLabel.intrinsicContentSize.height)
        ])
        
    }
    
    func setUpForm() {
        formStack = UIStackView()
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
        userNameInput = UITextField()
        passwordInput = UITextField()
        confirmPasswordInput = UITextField()
        
        registerButton = UIButton()
        
        [userNameInput, passwordInput, confirmPasswordInput].forEach {
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
            
            $0.layer.shadowColor = K.primaryColor.cgColor
            $0.layer.shadowOffset = CGSize.zero
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowRadius = 3.0
        }
        
        userNameInput.placeholder = "Username"
        userNameInput.textContentType = .username
        
        passwordInput.isSecureTextEntry = true
        passwordInput.textContentType = .newPassword
        passwordInput.placeholder = "Password"
        
        confirmPasswordInput.isSecureTextEntry = true
        confirmPasswordInput.textContentType = .newPassword
        confirmPasswordInput.placeholder = "Confirm Password"
        
        
        
        formStack.addArrangedSubview(userNameInput)
        formStack.addArrangedSubview(passwordInput)
        formStack.addArrangedSubview(confirmPasswordInput)
        formStack.addArrangedSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = K.primaryColor
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = 10
        
    }
    
    
    func setUpRegisterButton() {
        loginButton = UIButton()
        let registerHereText = UILabel()
        registerHereText.translatesAutoresizingMaskIntoConstraints = false
        registerHereText.text = "Already have an account?"
        
        let registerHereStack = UIStackView(arrangedSubviews: [
                registerHereText,
                loginButton
            ])
        
        registerHereStack.translatesAutoresizingMaskIntoConstraints = false

        registerHereStack.axis = .horizontal
        registerHereStack.alignment = .fill
        registerHereStack.distribution = .fill
        registerHereStack.spacing = 5

        formView.addSubview(registerHereStack)
        
        
        NSLayoutConstraint.activate([
            registerHereStack.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 10),
            registerHereStack.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 30)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(K.primaryColor, for: .normal)
        loginButton.setTitleColor(.gray, for: .focused)
        loginButton.heightAnchor.constraint(equalToConstant: 21).isActive = true
        loginButton.backgroundColor = .none
        
        loginButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
    }
}
