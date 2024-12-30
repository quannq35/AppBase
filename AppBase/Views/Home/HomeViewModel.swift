//
//  HomeViewModel.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

class HomeViewModel {
    
    // MARK: - Variables
    weak var coordinator: AppCoordinator?
    
    // MARK: - init
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}
