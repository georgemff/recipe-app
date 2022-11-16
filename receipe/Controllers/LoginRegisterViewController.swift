//
//  LoginRegisterViewController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 14.11.22.
//

import UIKit

class LoginRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.title = "Home"
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.text = "Hello"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        let dismissBtn = UIButton()
        view.addSubview(dismissBtn)
    
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        
//        dismissBtn.backgroundColor = .none
        dismissBtn.setTitleColor(.systemBlue, for: .normal)
        dismissBtn.setTitle("Dismiss", for: .normal)
    
        
        dismissBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dismissBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        dismissBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        dismissBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    @objc func dismissView() {
        dismiss(animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
