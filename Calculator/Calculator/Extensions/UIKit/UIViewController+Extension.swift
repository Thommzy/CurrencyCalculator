//
//  UIViewController+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/20/23.
//

import UIKit

// MARK: - UIViewController Extension

extension UIViewController {
    
    // MARK: - showAlert Method
    
    // Show an alert with the specified title and subtitle.
    // This method displays an UIAlertController with an "OK" button to dismiss the alert.
    // The title and subtitle parameters allow customizing the title and message (subtitle) of the alert.
    func showAlert(title: String?, subtitle: String?) {
        // Create an UIAlertController with the provided title and subtitle
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        // Add an "OK" button action to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the UIAlertController as a modal view
        present(alertController, animated: true, completion: nil)
    }
}
