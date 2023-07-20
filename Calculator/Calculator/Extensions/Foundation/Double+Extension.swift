//
//  Double+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/20/23.
//

import Foundation

// MARK: - Double Extension

// An extension to provide additional functionality to the Double class.
extension Double {
    // MARK: - Convert Double to String Method
    
    // Convert the Double value to its String representation.
    // This method simply uses the String initializer to convert the Double to a String.
    // The resulting string will be in the format appropriate for the current locale.
    func convertDoubleToString() -> String {
        return String(self)
    }
}
