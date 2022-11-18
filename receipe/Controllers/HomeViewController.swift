//
//  ViewController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 08.11.22.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    var topViewSearchBackground = UIView()
    var searchBar = UISearchBar()
    
    var stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nil
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSearchBar()
        
        view.addSubview(stackView)
        
        if !Auth().isAuth {
            let authBtn = AuthorizationButton()
            view.addSubview(authBtn)
            authBtn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                authBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
                authBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                authBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                authBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
            authBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logInOrRegister)))
            stackView.bottomAnchor.constraint(equalTo: authBtn.topAnchor).isActive = true
        } else {
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topViewSearchBackground.bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 70
    
        
        setUpTrends()
        setUpHotRecipes()
    }
    
    @objc func logInOrRegister() {
        print("He")
        let VC = LoginRegisterViewController()
        VC.modalPresentationStyle = .fullScreen
        VC.isModalInPresentation = true
        present(VC, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

//MARK: - Set Up UI
extension HomeViewController {
    
    func setUpSearchBar() {
        topViewSearchBackground.addSubview(searchBar)
        view.addSubview(topViewSearchBackground)
        
        topViewSearchBackground.translatesAutoresizingMaskIntoConstraints = false
        topViewSearchBackground.clipsToBounds = true
        topViewSearchBackground.layer.cornerRadius = 25
        topViewSearchBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topViewSearchBackground.backgroundColor = .systemOrange
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: topViewSearchBackground, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: topViewSearchBackground, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: topViewSearchBackground, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
        ])
        topViewSearchBackground.heightAnchor.constraint(equalToConstant: view.frame.height * 0.20).isActive = true
        
        //SearchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.leftView = nil
        searchBar.searchTextField.placeholder = "Search..."
        searchBar.searchTextField.returnKeyType = .search
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: topViewSearchBackground.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: topViewSearchBackground.trailingAnchor, constant: -20),
            searchBar.bottomAnchor.constraint(equalTo: topViewSearchBackground.bottomAnchor, constant: -20)
        ])
        let image = UIImage(named: "search_icon")
        let imageView = UIImageView(image: image)
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.addSubview(imageView)
        searchBar.searchTextField.rightView = imageView
        searchBar.searchTextField.rightViewMode = UITextField.ViewMode.always
    
    }
    
    
    
    func setUpTrends() {
        let trendView = createTrendView()
        let trendsTitleLabel = createViewTitleLabel(title: "Trends")
        trendView.addSubview(trendsTitleLabel)
        NSLayoutConstraint.activate([
            trendsTitleLabel.heightAnchor.constraint(equalToConstant: trendsTitleLabel.intrinsicContentSize.height),
            trendsTitleLabel.leadingAnchor.constraint(equalTo: trendView.leadingAnchor, constant: 10),
            trendsTitleLabel.topAnchor.constraint(equalTo: trendView.topAnchor, constant: 10),
            trendsTitleLabel.trailingAnchor.constraint(equalTo: trendView.trailingAnchor, constant: -10)
        ])
        
        let trend = Trends(imageName: "pizza", trendTitle: "Trend Title", complexityLabel: "Quick", review: "4.5", duration: "25", complexity: "Easy")
        trendView.addSubview(trend)
        NSLayoutConstraint.activate([
            trend.topAnchor.constraint(equalTo: trendsTitleLabel.bottomAnchor, constant: 10),
            trend.leadingAnchor.constraint(equalTo: trendView.leadingAnchor),
            trend.trailingAnchor.constraint(equalTo: trendView.trailingAnchor),
            trend.bottomAnchor.constraint(equalTo: trendView.bottomAnchor)
        ])
        
        
    }
    
    
    func createTrendView() -> UIView {
        let trendView = UIView()
        stackView.addArrangedSubview(trendView)
        trendView.translatesAutoresizingMaskIntoConstraints = false
        
        return trendView
    }
    
    func setUpHotRecipes() {
        let recipesView = UIView()
        stackView.addArrangedSubview(recipesView)
        recipesView.translatesAutoresizingMaskIntoConstraints = false;
        
        
        let hotRecipesLabel = createViewTitleLabel(title: "Hot Recipes")
        recipesView.addSubview(hotRecipesLabel)
        
        
        NSLayoutConstraint.activate([
            hotRecipesLabel.heightAnchor.constraint(equalToConstant: hotRecipesLabel.intrinsicContentSize.height),
            hotRecipesLabel.leadingAnchor.constraint(equalTo: recipesView.leadingAnchor, constant: 10),
            hotRecipesLabel.topAnchor.constraint(equalTo: recipesView.topAnchor, constant: 0),
            hotRecipesLabel.trailingAnchor.constraint(equalTo: recipesView.trailingAnchor, constant: -10)
        ])
        let recipesStack = UIStackView()
        recipesView.addSubview(recipesStack)

        recipesStack.translatesAutoresizingMaskIntoConstraints = false
        recipesStack.axis = .vertical
        recipesStack.distribution = .fillEqually
        recipesStack.spacing = 10
        recipesStack.alignment = .fill
        
        NSLayoutConstraint.activate([
            recipesStack.topAnchor.constraint(equalTo: hotRecipesLabel.bottomAnchor, constant: 10),
            recipesStack.leadingAnchor.constraint(equalTo: recipesView.leadingAnchor, constant: 10),
            recipesStack.trailingAnchor.constraint(equalTo: recipesView.trailingAnchor, constant: -10),
        ])
        
        [
            RecipeCell(image: "pasta", title: "Pasta", description: "Some Pasta Recipe Description"),
            RecipeCell(image: "pizza", title: "Pizza", description: "Some Pizza Recipe Description")
        ].forEach{recipesStack.addArrangedSubview($0)}

        recipesStack.arrangedSubviews.forEach {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: recipesStack.leadingAnchor, constant: 0),
                $0.trailingAnchor.constraint(equalTo: recipesStack.trailingAnchor, constant: 0)
            ])
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cellTapped(_:))))
        }
       
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        print(sender)
        print(true)
    }

    
    func createViewTitleLabel(title: String) -> UILabel {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        return titleLabel
    }
}

