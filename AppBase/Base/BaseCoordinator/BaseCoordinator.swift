//
//  BaseCoordinator.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation
import UIKit

protocol BaseCordinator: AnyObject {
    var navigationController: BaseNavigationController { get set }
    func start(animated: Bool)
    func navigate(to route: AppRoute)
}

extension BaseCordinator {
    func popViewController(animated: Bool, useCustomAnimation: Bool = false, transitionType: CATransitionType = .push) {
        if useCustomAnimation {
            navigationController.customPopViewController(transitionType: transitionType)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }

    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        navigationController.popToViewController(ofClass: ofClass, animated: animated)
    }
    
    func popViewController(to viewController: UIViewController, animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType = .push) {
        if useCustomAnimation {
            navigationController.customPopToViewController(viewController: viewController, transitionType: transitionType)
        } else {
            navigationController.popToViewController(viewController, animated: animated)
        }
    }
}
