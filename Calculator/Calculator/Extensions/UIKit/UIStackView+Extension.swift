//
//  UIStackView+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//

import UIKit

// MARK: - UIStackView Extension

// An extension to provide a convenient way to create a UIStackView with custom configurations.
public extension UIStackView {
    
    // MARK: - create Method
    
    // Create a UIStackView with specified properties and subviews.
    // This method allows creating a UIStackView with custom spacing, axis, alignment, distribution, padding, and subviews.
    // The stackview closure can be used to further customize the UIStackView if needed.
    static func create(
        spacing: CGFloat = 0,
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment,
        distribution: UIStackView.Distribution,
        padding: UIEdgeInsets? = nil,
        views: [UIView],
        stackview: ((UIStackView) -> Void)? = nil
    ) -> UIStackView {
        // Create the UIStackView with the specified properties and subviews
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.spacing = spacing
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        
        // Allow further customization using the stackview closure, if provided
        stackview?(stackView)
        
        // Disable autoresizing masks and apply layout margins if padding is provided
        stackView.translatesAutoresizingMaskIntoConstraints = false
        if let padding = padding {
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = padding
        }
        
        return stackView
    }
}
