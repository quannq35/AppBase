//
//  ProfileViewController.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: - Variables
    var viewModel: ProfileViewModel!
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localizable_strings.profileTitle
    }
    
    // MARK: IBActions
    @IBAction func termsAndConditionsTapped(_ sender: UIButton) {
        viewModel.termsAndConditions()
    }
}

