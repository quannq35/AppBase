//
//  ProfileViewModel.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation

class ProfileViewModel {
    
    // MARK: - Variables
    var coordinator: AppCoordinator
        
    // MARK: - init
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Navigation
    func termsAndConditions() {
        coordinator.navigate(to: .profileDetail)
    }
}
