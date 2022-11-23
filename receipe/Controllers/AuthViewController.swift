//
//  AuthViewController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 22.11.22.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    var formView: UIView!
    var formStack: UIStackView!
    var authLabel: UILabel!
    var userNameInput: UITextField!
    var passwordInput: UITextField!
    var registerButton: UIButton!
    var loginButton: UIButton!
    
    var login = true
    
    var loginView = UIView()
    var registerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nil
        setUpUI()
        
    }
    
    func setUpUI() {
       
            setUpFormView()
            setUpForm()
            setUpRegisterButton()
    }

}

//MARK: - Log In UI
extension AuthViewController {
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
        authLabel.text = "Login"
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
        
        loginButton = UIButton()
        
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
            
            $0.layer.shadowColor = K.primaryColor.cgColor
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
        formStack.addArrangedSubview(loginButton)
        
        //Login Button Styles
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = K.primaryColor
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 10
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        
    }
    
    
    func setUpRegisterButton() {
        registerButton = UIButton()
        let registerHereText = UILabel()
        registerHereText.translatesAutoresizingMaskIntoConstraints = false
        registerHereText.text = "Don't have an account?"
        
        let registerHereStack = UIStackView(arrangedSubviews: [
                registerHereText,
                registerButton
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
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(K.primaryColor, for: .normal)
        registerButton.setTitleColor(.gray, for: .focused)
        registerButton.heightAnchor.constraint(equalToConstant: 21).isActive = true
        registerButton.backgroundColor = .none
        
        addGestureToButton()
    }
}

//MARK: - Login Logic
extension AuthViewController {
    func addGestureToButton() {
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }
    
    @objc func registerButtonPressed(_ target: UIButton) {
        
        target.alpha = 0.5
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            target.alpha = 1
        }
        
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .pageSheet
        self.present(registerVC, animated: true)
        
    }
    
    @objc func loginButtonPressed(_ target: UIButton) {
        FirebaseAuth.Auth.auth().signIn(withEmail: userNameInput.text!, password: passwordInput.text!) {result, error in
            if let e = error {
                print(e.localizedDescription)
                return
            }
        }
    }
}
