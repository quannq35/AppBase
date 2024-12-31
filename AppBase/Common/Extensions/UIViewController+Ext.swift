//
//  UIViewController+Ext.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import Foundation
import UIKit

public extension UIViewController {
    
    func openAlert(title: String, message: String, alertStyle: UIAlertController.Style, actionTitles: [String], actionStyle: [UIAlertAction.Style], actions: [((UIAlertAction) -> Void )?]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for (index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle, style: actionStyle[index],
            handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
