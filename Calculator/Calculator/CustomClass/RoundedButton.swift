//
//  RoundedButton.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
