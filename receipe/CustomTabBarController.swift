//
//  TabBarController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 13.11.22.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar(), forKey: "tabBar")
        delegate = self
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
        
        setUpVCs()
        

        
    }
    
    override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
        let realTraits = super.traitCollection
        let fakeTraits = UITraitCollection(horizontalSizeClass: .regular)

        return UITraitCollection(traitsFrom: [realTraits, fakeTraits])
    }
    
    
    
    
    func setUpVCs() {

        viewControllers = [
            createNavController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house.fill")!),
            createNavController(for: EmptyViewController(), title: nil, image: nil),
            createNavController(for: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person.crop.circle")!),
        ]
        
        
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String?, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        tabBar.tintColor = .systemYellow
        
        return navController
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

extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        //Disable Middle Tab Index
        if selectedIndex == 1 {
            return false
        }
        
        return true
    }
}


//Class For Middle Tab Bat Item Controller
class EmptyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
