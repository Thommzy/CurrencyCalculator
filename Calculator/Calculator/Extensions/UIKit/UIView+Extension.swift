//
//  UIView+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/13/23.
//

import UIKit

// MARK: - UIView Extension

// An extension to provide additional layout-related functionality to the UIView class.
extension UIView {
    // typealias for NSLayoutConstraint array for readability
    typealias Constraints = [NSLayoutConstraint]
    
    // MARK: - Anchor Method
    
    // Anchor the view to its superview or specified anchors with optional padding and height constraints.
    // This method allows setting constraints for the top, left, bottom, right, paddingTop, paddingLeft, paddingBottom, paddingRight, and height of the view.
    // All constraints are activated, and the view is set to not use autoresizing masks.
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    // MARK: - addSubview Method
    
    // Add an array of subviews to the view.
    // This method sets each subview's `translatesAutoresizingMaskIntoConstraints` property to false and adds them as subviews of the current view.
    func addSubview(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    // MARK: - Constraints Methods
    
    // Helper methods to create specific layout constraints.
    
    // Create constraints for a specific width.
    func constraintsForWidth(_ width: CGFloat) -> Constraints {
        return [
            widthAnchor.constraint(equalToConstant: width),
        ]
    }
    
    // Create constraints for a specific height.
    func constraintsForHeight(_ height: CGFloat) -> Constraints {
        return [
            heightAnchor.constraint(equalToConstant: height),
        ]
    }
    
    // Create constraints for a specific size (width and height).
    func constraintsForSize(size: CGSize) -> Constraints {
        return [
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
        ]
    }
    
    // Create constraints for all edges (leading, trailing, top, bottom) to a specified view with insets.
    func constraintsForEdges(to view: UIView, insets: UIEdgeInsets) -> Constraints {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
        ]
    }
    
    // MARK: - Constrain Methods
    
    // Convenience methods to activate and set constraints.
    
    // Constrain the width of the view.
    @discardableResult
    func constrainWidth(_ width: CGFloat) -> Constraints {
        let constraints = constraintsForWidth(width)
        constrain(constraints)
        return constraints
    }
    
    // Constrain the height of the view.
    @discardableResult
    func constrainHeight(_ height: CGFloat) -> Constraints {
        let constraints = constraintsForHeight(height)
        constrain(constraints)
        return constraints
    }
    
    // Constrain the width and height of the view.
    @discardableResult
    func constrainSize(width: CGFloat, height: CGFloat) -> Constraints {
        let constraints = constraintsForSize(size: CGSize(width: width, height: height))
        constrain(constraints)
        return constraints
    }
    
    // Constrain the view to its superview with a specific padding.
    @discardableResult
    func constrainToSuperview(padding: CGFloat = 0) -> Constraints {
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let constraints = constraintsForEdges(to: superview!, insets: insets)
        constrain(constraints)
        return constraints
    }
    
    // MARK: - Center Constraints
    
    // Center the view horizontally in its superview.
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    // Center the view vertically in its superview.
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    // MARK: - Activate Constraints
    
    // Activate the given constraints.
    func constrain(_ constraint: Constraints) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraint)
    }
}
