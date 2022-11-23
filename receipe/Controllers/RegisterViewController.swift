//
//  RegisterViewController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 23.11.22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    var formView: UIView!
    var formStack: UIStackView!
    var authLabel: UILabel!
    var emailInput: UITextField!
    var usernameInput: UITextField!
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
        setUpLoginButton()
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
        
        usernameInput = UITextField()
        emailInput = UITextField()
        passwordInput = UITextField()
        confirmPasswordInput = UITextField()
        
        registerButton = UIButton()
        
        [emailInput, usernameInput, passwordInput, confirmPasswordInput].forEach {
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
        
        emailInput.placeholder = "Email"
        emailInput.textContentType = .emailAddress
        
        usernameInput.placeholder = "Username"
        usernameInput.textContentType = .username
        
        passwordInput.isSecureTextEntry = true
        passwordInput.textContentType = .newPassword
        passwordInput.placeholder = "Password"
        
        confirmPasswordInput.isSecureTextEntry = true
        confirmPasswordInput.textContentType = .newPassword
        confirmPasswordInput.placeholder = "Confirm Password"
        
        
        
        formStack.addArrangedSubview(emailInput)
        formStack.addArrangedSubview(usernameInput)
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
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)

        
    }
    
    
    func setUpLoginButton() {
        loginButton = UIButton()
        let haveAccountText = UILabel()
        haveAccountText.translatesAutoresizingMaskIntoConstraints = false
        haveAccountText.text = "Already have an account?"
        
        let haveAccountStack = UIStackView(arrangedSubviews: [
            haveAccountText,
            loginButton
        ])
        
        haveAccountStack.translatesAutoresizingMaskIntoConstraints = false
        
        haveAccountStack.axis = .horizontal
        haveAccountStack.alignment = .fill
        haveAccountStack.distribution = .fill
        haveAccountStack.spacing = 5
        
        formView.addSubview(haveAccountStack)
        
        
        NSLayoutConstraint.activate([
            haveAccountStack.leadingAnchor.constraint(equalTo: formView.leadingAnchor, constant: 10),
            haveAccountStack.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 20),
            haveAccountStack.bottomAnchor.constraint(equalTo: formView.bottomAnchor, constant: 0)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(K.primaryColor, for: .normal)
        loginButton.backgroundColor = .none
        loginButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
    }
    
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
}

extension RegisterViewController {
    
    @objc func registerButtonPressed(_ target: UIButton) {
        target.alpha = 0.5
        
        target.isUserInteractionEnabled = false
        print(validateForm())
        if !validateForm() {
            target.alpha = 1
            target.isUserInteractionEnabled = true
            
            return
        }
        
        
        FirebaseAuth.Auth.auth().createUser(withEmail: emailInput.text!, password: passwordInput.text!) {
            (result, error) in
            if let e = error {
                print(e.localizedDescription)
                target.alpha = 1
                target.isUserInteractionEnabled = true
                return
            }
            
            let changesRequest = result?.user.createProfileChangeRequest()
            changesRequest?.displayName = self.usernameInput.text!
            changesRequest?.commitChanges() {
                error in print(error?.localizedDescription)
            }
            
            result?.user.sendEmailVerification() {
                error in
                print(error?.localizedDescription)
                
            }

            self.dismissVC()
        }
    }
    
    func validateForm() -> Bool {
        
        if emailInput.text == nil ||
            (emailInput.text != nil && emailInput.text!.isEmpty){
            return false
        }
        
        if usernameInput.text == nil ||
            (usernameInput.text != nil &&  usernameInput.text!.isEmpty){
            return false
        }
        
        if passwordInput.text == nil ||
            (passwordInput.text != nil &&  passwordInput.text!.isEmpty){
            return false
        }
        
        if confirmPasswordInput.text == nil ||
            (confirmPasswordInput.text != nil &&  confirmPasswordInput.text!.isEmpty){
            return false
        }
        
        if passwordInput.text! != confirmPasswordInput.text! {
            return false
        }
        
        return true
    }
}
