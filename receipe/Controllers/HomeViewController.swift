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
    
    var trendsCollectionView: UICollectionView!
    var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSearchBar()
        setUpCollectionView()
        setUpStackView()
        setUpTrends()
        setUpRecipesTableView()
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
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        trendsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        trendsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "trendsCell")
        trendsCollectionView.isPagingEnabled = true
        trendsCollectionView.showsHorizontalScrollIndicator = false
        trendsCollectionView.clipsToBounds = false
        trendsCollectionView.dataSource = self
        trendsCollectionView.delegate = self
    }
    
    func setUpStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 70
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topViewSearchBackground.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setUpRecipesTableView() {
        recipesTableView = UITableView()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        
        recipesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "recipeCell")
        recipesTableView.separatorStyle = .none
        recipesTableView.showsVerticalScrollIndicator = false
        recipesTableView.rowHeight = 100
//        recipesTableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func setUpSearchBar() {
        topViewSearchBackground.addSubview(searchBar)
        view.addSubview(topViewSearchBackground)
        
        topViewSearchBackground.translatesAutoresizingMaskIntoConstraints = false
        topViewSearchBackground.clipsToBounds = true
        topViewSearchBackground.layer.cornerRadius = 25
        topViewSearchBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topViewSearchBackground.backgroundColor = K.primaryColor
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
        
        trendView.addSubview(trendsCollectionView)
        trendsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trendsCollectionView.leadingAnchor.constraint(equalTo: trendView.leadingAnchor),
            trendsCollectionView.topAnchor.constraint(equalTo: trendsTitleLabel.bottomAnchor),
            trendsCollectionView.trailingAnchor.constraint(equalTo: trendView.trailingAnchor),
            trendsCollectionView.bottomAnchor.constraint(equalTo: trendView.bottomAnchor),
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
        
        recipesView.addSubview(recipesTableView)
        recipesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipesTableView.topAnchor.constraint(equalTo: hotRecipesLabel.bottomAnchor, constant: 10),
            recipesTableView.leadingAnchor.constraint(equalTo: recipesView.leadingAnchor),
            recipesTableView.trailingAnchor.constraint(equalTo: recipesView.trailingAnchor),
            recipesTableView.bottomAnchor.constraint(equalTo: recipesView.bottomAnchor, constant: -10),
        ])
        
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

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trendsCell", for: indexPath)
        cell.clipsToBounds = false
        cell.backgroundColor = .none
        var trend: Trends
        
        if indexPath.row % 2 == 0 {
            trend = Trends(imageName: "pizza", trendTitle: "Best Pizza", complexityLabel: "Medium", review: "4.5", duration: "60", complexity: "Medium")
        } else {
            trend = Trends(imageName: "pasta", trendTitle: "Best Pasta", complexityLabel: "Quick", review: "4.5", duration: "15", complexity: "Easy")
        }
        
        cell.addSubview(trend)
        NSLayoutConstraint.activate([
            trend.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            trend.topAnchor.constraint(equalTo: cell.topAnchor),
            trend.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            trend.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
        ])
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.selectionStyle = .none
        for v in cell.subviews {
            v.removeFromSuperview()
        }
        
        let recipe: RecipeCell
        
        if indexPath.row % 2 == 0 {
            recipe = RecipeCell(image: "pasta", title: "Pasta", description: "Some Pasta Recipe Description")
        } else {
            recipe = RecipeCell(image: "pizza", title: "Pizza", description: "Some Pizza Recipe Description")
        }
        
        cell.addSubview(recipe)
        NSLayoutConstraint.activate([
            recipe.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            recipe.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5),
            recipe.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            recipe.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -5)
        ])
        return cell
    }
    
    
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
