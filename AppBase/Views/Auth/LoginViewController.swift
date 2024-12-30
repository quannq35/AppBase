//
//  LoginViewController.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import UIKit

class LoginViewController: BaseViewController {

    // MARK: - Variables
    var viewModel: LoginViewModel!
    
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: IBActions
    @IBAction func loginTapped(_ sender: UIButton) {
        viewModel.performLogin()
    }
}
