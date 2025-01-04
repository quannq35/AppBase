//
//  BaseTabbarController.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    // MARK: - Variables
    var coordinator: AppCoordinator?
    
    // MARK: - init
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: "BaseTabBarController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabBar()
    }
    
    func setupTabBar() {
        let homeViewController = HomeViewController()
        let profileViewController = ProfileViewController()
        
        if let coordinator = coordinator {
            let viewModel = ProfileViewModel(coordinator: coordinator)
            profileViewController.viewModel = viewModel
        }
        
        let homeNav = BaseNavigationController(rootViewController: homeViewController)
        let profileNav = BaseNavigationController(rootViewController: profileViewController)
        
        homeNav.tabBarItem = UITabBarItem( title: Localizable_strings.homeTitle,
                                           image: UIImage(systemName: "house.fill"),
                                           selectedImage: nil)
        
        profileNav.tabBarItem = UITabBarItem(title: Localizable_strings.profileTitle,
                                             image: UIImage(systemName: "person.crop.circle"),
                                             selectedImage: nil)
        
        self.viewControllers = [homeNav, profileNav]
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            UITableView.appearance().sectionHeaderTopPadding = 1
        }
    }
}
extension BaseTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
