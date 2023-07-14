//
//  CurrencyButtonView.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//

import UIKit

@IBDesignable
final class CurrencyButtonView: UIView {
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor(named: "PrimaryTextFieldBackground")?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var mainStackView = UIStackView.create(
        spacing: 5,
        axis: .horizontal,
        alignment: .fill,
        distribution: .fill,
        views: []
    )
    
    @IBInspectable
    var customRadius: CGFloat = 0.0 {
        didSet {
            baseView.layer.cornerRadius = customRadius
            baseView.layer.masksToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}

extension CurrencyButtonView {
    private func setupViews() {
        prepareViews()
        prepareConstraints()
    }
    
    private func prepareViews() {
        addSubview(baseView)
        baseView.addSubview(
            [
                mainStackView
            ]
        )
    }
    
    private func prepareConstraints() {
        baseView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        mainStackView.constrainToSuperview()
    }
}
