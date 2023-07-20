//
//  CurrencyTextField.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/14/23.
//

import UIKit

// MARK: - CurrencyTextField Class

// A custom UITextField subclass to handle currency formatting and input validation.
final class CurrencyTextField: UITextField, UITextFieldDelegate {
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup Method
    
    // Setup the CurrencyTextField with required configurations.
    private func setup() {
        delegate = self
        keyboardType = .decimalPad
        addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: - Formatting Method
    
    // Format the text in the text field as currency.
    private func formatText() {
        guard let text = text, !text.isEmpty else {
            return
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        if let number = formatter.number(from: text) {
            let formattedString = formatter.string(from: number)
            super.text = formattedString
        } else {
            super.text = text
        }
    }

    // MARK: - UITextFieldDelegate Methods
    
    // Handle text change events to apply formatting.
    @objc private func textFieldEditingChanged() {
        formatText()
    }
    
    // Validate text input and enforce formatting restrictions.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        // Allow backspace
        if string.isEmpty {
            return true
        }
        
        // Allow only digits and a single decimal point
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789.")
        let replacementStringCharacterSet = CharacterSet(charactersIn: string)
        let containsOnlyAllowedCharacters = allowedCharacterSet.isSuperset(of: replacementStringCharacterSet)
        
        if !containsOnlyAllowedCharacters {
            return false
        }
        
        // Ensure only one decimal point is present
        let existingTextHasDecimalSeparator = text.range(of: ".") != nil
        let replacementStringHasDecimalSeparator = string.range(of: ".") != nil
        
        if existingTextHasDecimalSeparator && replacementStringHasDecimalSeparator {
            return false
        }
        
        // Limit the total number of decimal places to 2
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let components = text.components(separatedBy: decimalSeparator)
        
        if components.count > 1 {
            let decimalPlaces = components[1]
            
            if decimalPlaces.count >= 2 {
                return false
            }
        }
        
        return true
    }
}
