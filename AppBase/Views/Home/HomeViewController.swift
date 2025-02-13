//
//  HomeViewController.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import UIKit

class HomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizable_strings.homeTitle
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIClient.shared.createUser(name: "Quannq", job: "ios") { result in
            switch result {
            case .success(let data):
                if let user = data {
                    print(user.name, user.job)
                }
            case .failure(let error):
                print(error)
            }
        }
        
//        APIClient.shared.getUsers { result in
//            switch result {
//                case .success(let data):
//                if let users = data?.data {
//                    users.forEach { user in
//                        print(user.firstName, user.email)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
