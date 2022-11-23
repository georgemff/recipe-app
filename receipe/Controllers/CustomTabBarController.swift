//
//  TabBarController.swift
//  receipe
//
//  Created by Giorgi Adeishvili on 13.11.22.
//

import UIKit
import FirebaseAuth

class CustomTabBarController: UITabBarController {
    
    var listener: AuthStateDidChangeListenerHandle!
    var authModel = Auth()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        delegate = self
        setValue(CustomTabBar(), forKey: "tabBar")
        guard let tabBar = self.tabBar as? CustomTabBar else {return}
        tabBar.didTapButton = { [unowned self] in
            self.middleButtonPressed()
        }
        
        view.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        
        setUpVCs()
    }
    
    func middleButtonPressed() {
        if !authModel.isAuth {
            let vc = AuthViewController()
            
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listener = FirebaseAuth.Auth.auth().addStateDidChangeListener { auth, user in
                self.authModel.setAuth(!(user == nil))
                self.setUpVCs()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FirebaseAuth.Auth.auth().removeStateDidChangeListener(listener)

    }
    
    override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
        let realTraits = super.traitCollection
        let fakeTraits = UITraitCollection(horizontalSizeClass: .regular)

        return UITraitCollection(traitsFrom: [realTraits, fakeTraits])
    }
    
    
    
    
    func setUpVCs() {
        
        let profileController: UIViewController = authModel.isAuth ? ProfileViewController() : AuthViewController()

        viewControllers = [
            createNavController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house.fill")!),
            createNavController(for: EmptyViewController(), title: nil, image: nil),
            createNavController(for: profileController, title: "Profile", image: UIImage(systemName: "person.crop.circle")!),
        ]
        
        self.tabBar.layoutIfNeeded()
        
        
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String?, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        tabBar.tintColor = K.primaryColor
        
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
