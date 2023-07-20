//
//  AppString.swift
//  Calculator
//
//  Created by Ti

import Foundation

public enum AppString:String {
    public var localisedValue:String {
        return self.rawValue.getLocalizedValue()
    }
    
    case https
    case baseURL
    case latest
}
