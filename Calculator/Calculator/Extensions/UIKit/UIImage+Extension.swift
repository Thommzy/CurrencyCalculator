//
//  UIImage+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import UIKit

extension UIImage {
    static func roundedFlagEmoji(for countryCode: String, size: CGSize, backgroundColor: UIColor, textColor: UIColor, font: UIFont) -> UIImage? {
        let base: UInt32 = 127397
        var flagString = ""
        for scalar in countryCode.unicodeScalars {
            let scalarValue = scalar.value
            if let scalarSymbol = UnicodeScalar(base + scalarValue) {
                flagString.append(String(scalarSymbol))
            }
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            let circlePath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: size))
            backgroundColor.setFill()
            circlePath.fill()
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: textColor
            ]
            let text = NSAttributedString(string: flagString, attributes: attributes)
            let textSize = text.size()
            let textOrigin = CGPoint(x: (size.width - textSize.width) / 2, y: (size.height - textSize.height) / 2)
            text.draw(at: textOrigin)
        }
        
        return image
    }
}
