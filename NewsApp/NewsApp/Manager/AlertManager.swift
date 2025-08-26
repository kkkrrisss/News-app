//
//  UIAlertController.swift
//  NewsApp
//
//  Created by Кристина Олейник on 18.08.2025.
//

import UIKit

final class AlertManager {
    static func showAlert(on viewController: UIViewController,
                          title: String = "Error",
                          message: String,
                          buttonTitle: String = "Cancel") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
}
