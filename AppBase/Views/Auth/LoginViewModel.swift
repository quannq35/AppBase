//
//  LoginViewModel.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Variables
    var coordinator: AppCoordinator?
    // MARK: - init
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    
    // MARK: - Actions
    func performLogin() {
        UserDefaults.standard.set("true", forKey: "loggedIn")
        coordinator?.navigate(to: .app)

    }
}

