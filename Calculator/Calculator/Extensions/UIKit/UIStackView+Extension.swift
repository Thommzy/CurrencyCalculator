//
//  UIStackView+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//

import UIKit

public extension UIStackView {

    static func create(
        spacing: CGFloat = 0,
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment,
        distribution: UIStackView.Distribution,
        padding: UIEdgeInsets? = nil,
        views: [UIView],
        stackview: ((UIStackView) -> Void)? = nil
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.spacing = spacing
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackview?(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        if let padding = padding {
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = padding
        }
        return stackView
    }

}
