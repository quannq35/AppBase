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
        self.title = "Home"
        APIClient.shared.getUsers { result in
            switch result {
            case.success(let users):
                if let users = users, let userData = users.data {
                    userData.forEach({ user in
                        print(user.firstName ?? "")
                        print(user.email ?? "")
                        print("")
                    })
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
