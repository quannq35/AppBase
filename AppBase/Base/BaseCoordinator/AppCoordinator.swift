//
//  AppCoordinator.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCordinator {
    var navigationController: BaseNavigationController
    var tabBarController: BaseTabBarController?
    var topViewController: UIViewController? {
        return getTopVc()
    }
    // MARK: - init & start
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start(animated: Bool) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        if isLoggedIn {
            navigate(to: .app)
        } else {
            navigate(to: .login)
        }
    }
    
    func navigate(to route: AppRoute) {
        switch route {
        case .login:
            let loginViewController = LoginViewController()
            loginViewController.viewModel = LoginViewModel(coordinator: self)
            navigationController.setViewControllers([loginViewController], animated: false)
        case .app:
            let baseTabBarController = BaseTabBarController(coordinator: self)
            tabBarController = baseTabBarController
            navigationController.setViewControllers([baseTabBarController], animated: false)
        case .profileDetail:
            let profileDetail = ProfileDetailViewController()
            topViewController?.navigationController?.pushViewController(profileDetail, animated: true)
            
        default:
            break
        }
    }
}

extension AppCoordinator {
    private func getTopVc() -> UIViewController? {
        if let presentedViewController = navigationController.presentedViewController {
            return getTopViewController(from: presentedViewController)
        }
        
         if let tabBarController = tabBarController, let selectedVC = (tabBarController.selectedViewController as? UINavigationController)?.topViewController {
            return getTopViewController(from: selectedVC)
        }
        return navigationController.topViewController
    }
    
    private func getTopViewController(from viewController: UIViewController) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return getTopViewController(from: navigationController.viewControllers.last!) }
        if let tabBarController = viewController as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return getTopViewController(from: selected)
            }
        }
        
        if let presentedViewController = viewController.presentedViewController {
            return getTopViewController(from: presentedViewController) }
        return viewController
    }
}
