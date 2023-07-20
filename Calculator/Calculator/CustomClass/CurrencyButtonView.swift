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
    
    lazy var leftImageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var currency: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var rightImageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private lazy var mainStackView = UIStackView.create(
        spacing: 5,
        axis: .horizontal,
        alignment: .fill,
        distribution: .fill,
        views: [
            leftImageContainer,
            currency,
            rightImageContainer
        ]
    )
    
    @IBInspectable
    var customRadius: CGFloat = 0.0 {
        didSet {
            baseView.layer.cornerRadius = customRadius
            baseView.layer.masksToBounds = true
        }
    }
    
//    @IBInspectable
//    var leftImageCornerRadius: CGFloat = 0.0 {
//        didSet {
//            leftImage.layer.cornerRadius = 10
//            leftImage.layer.masksToBounds = true
//        }
//    }
    
    @IBInspectable
    var currencyText: String? {
        didSet {
            currency.text = currencyText
        }
    }
    
    @IBInspectable
    var customFlag: String? {
        didSet {
            leftLabel.text = "".countryFlag(rateCode: customFlag ?? "")
        }
    }
    
    @IBInspectable
    var customRightImage: UIImage? {
        didSet {
            rightImage.image = customRightImage
        }
    }
    
    public var onTap:(() -> Void)?
    
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
        setupActions()
    }
    
    private func prepareViews() {
        addSubview(baseView)
        baseView.addSubview(
            [
                mainStackView
            ]
        )
        
        leftImageContainer.addSubview(leftLabel)
        rightImageContainer.addSubview(rightImage)
    }
    
    private func prepareConstraints() {
        baseView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        mainStackView.constrainToSuperview()
        
//        leftImage.constrainSize(width: 20, height: 20)
        leftLabel.centerXInSuperview()
        leftLabel.centerYInSuperview()
        
        rightImage.constrainSize(width: 25, height: 25)
        rightImage.centerXInSuperview()
        rightImage.centerYInSuperview()
        
        leftImageContainer.widthAnchor.constraint(equalTo: rightImageContainer.widthAnchor).isActive = true
    }
    
    func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        guard let onTap = onTap else { return }
        onTap()
    }
}
