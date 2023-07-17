//
//  RounedView.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//
//
//import UIKit
//
//@IBDesignable
//class RoundedView: UIView {
//
//    @IBInspectable var topCornerRadius: CGFloat = 0 {
//        didSet {
//            clipsToBounds = true
//            layer.cornerRadius = topCornerRadius
//            layer.maskedCorners = [.layer, .layerMinXMinYCorner]
//        }
//    }
//
//    @IBInspectable var bottomCornerRadius: CGFloat = 0 {
//        didSet {
//            clipsToBounds = true
//            layer.cornerRadius = bottomCornerRadius
//            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//
//    private func setupView() {
//        layer.cornerRadius = cornerRadius
//        layer.masksToBounds = true
//    }
//}

//import UIKit
//
//@IBDesignable
//class CustomView: UIView {
//
//    @IBInspectable var topCornerRadius: CGFloat = 0 {
//        didSet {
//            updateCorners()
//        }
//    }
//
//    @IBInspectable var bottomCornerRadius: CGFloat = 0 {
//        didSet {
//            updateCorners()
//        }
//    }
//
//    private func updateCorners() {
//        layer.masksToBounds = true
//        let corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        layer.cornerRadius = topCornerRadius
//        layer.maskedCorners = corners
//
//        let bottomCorners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        let bottomPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: bottomCorners, cornerRadii: CGSize(width: bottomCornerRadius, height: bottomCornerRadius))
//        let bottomLayer = CAShapeLayer()
//        bottomLayer.path = bottomPath.cgPath
//        layer.addSublayer(bottomLayer)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateCorners()
//    }
//}

import UIKit

@IBDesignable
class RoundedView: UIView {
    
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
//
//    private func updateCorners() {
//        layer.masksToBounds = true
//
//        let topCorners: UIRectCorner = [.topLeft, .topRight]
//        let topPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: topCorners, cornerRadii: CGSize(width: topCornerRadius, height: topCornerRadius))
//        let topLayer = CAShapeLayer()
//        topLayer.path = topPath.cgPath
//        layer.mask = topLayer
//
//        let bottomCorners: UIRectCorner = [.bottomLeft, .bottomRight]
//        let bottomPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: bottomCorners, cornerRadii: CGSize(width: bottomCornerRadius, height: bottomCornerRadius))
//        let bottomLayer = CAShapeLayer()
//        bottomLayer.path = bottomPath.cgPath
//        layer.addSublayer(bottomLayer)
//    }
    
    func roundTopCorners() {
        clipsToBounds = true
        layer.cornerRadius = topCornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundTopCorners()
    }
}
