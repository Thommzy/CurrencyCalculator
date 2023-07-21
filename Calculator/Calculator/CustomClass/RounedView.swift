//
//  RounedView.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable var topCornerRadius: CGFloat = 0 {
        didSet {
            roundTopCorners()
        }
    }
    
    @IBInspectable var bottomCornerRadius: CGFloat = 0 {
        didSet {
            roundTopCorners()
        }
    }

    
    // MARK: - Corner Rounding Method
    
    func roundTopCorners() {
        clipsToBounds = true
        layer.cornerRadius = topCornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundTopCorners()
    }
}
