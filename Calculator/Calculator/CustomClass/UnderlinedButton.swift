//
//  UnderlinedButton.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//

import UIKit

@IBDesignable
class UnderlinedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBInspectable
    var customFont: CGFloat = 0.0 {
        didSet {
            underlineText(withFontSize: customFont)
        }
    }
    
    func underlineText(withFontSize fontSize: CGFloat) {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.boldSystemFont(ofSize: fontSize)
        ]
        
        attributedString.addAttributes(
            attributes,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
