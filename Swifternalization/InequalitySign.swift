//
//  InequalitySign.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Defines inequality signs used by inquality and inequality extended expressions.
*/
enum InequalitySign: String {
    /// Less than a value
    case LessThan = "<"
    /// Less than or equal a value
    case LessThanOrEqual = "<="
    /// Equal a value
    case Equal = "="
    /// Greater than or equal a value
    case GreaterThanOrEqual = ">="
    /// Greater than a value
    case GreaterThan = ">"
    
    /// Inverts enum
    func invert() -> InequalitySign {
        switch self {
        case .LessThan: return .GreaterThan
        case .LessThanOrEqual: return .GreaterThanOrEqual
        case .Equal: return .Equal
        case .GreaterThanOrEqual: return .LessThanOrEqual
        case .GreaterThan: return .LessThan
        }
    }
}