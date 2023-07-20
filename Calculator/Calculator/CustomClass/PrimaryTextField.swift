//
//  PrimaryTextField.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/13/23.
//

import UIKit

@IBDesignable
final class PrimaryTextFieldView: UIView {
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "PrimaryTextFieldBackground")
        return view
    }()
    
    lazy var mainTextField: CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.tintColor = .black
        textField.font = .boldSystemFont(ofSize: 18)
        return textField
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .lightGray
        label.constrainWidth(40)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var mainStackView = UIStackView.create(
        spacing: 5,
        axis: .horizontal,
        alignment: .fill,
        distribution: .fill,
        views: [
            mainTextField,
            rightLabel
        ]
    )
    
    @IBInspectable
    var customRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = customRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var rightLabelText: String? {
        didSet {
            rightLabel.text = rightLabelText
        }
    }
    
    @IBInspectable
    var customPlaceHolder: String? {
        didSet {
            mainTextField.placeholder = customPlaceHolder
        }
    }
    
    public func getText() -> String {
        return mainTextField.text ?? ""
    }
    
    public func setText(newText: String) {
        mainTextField.text = newText
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

extension PrimaryTextFieldView {
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
        
        mainStackView.constrainToSuperview(padding: 12)
    }
}
