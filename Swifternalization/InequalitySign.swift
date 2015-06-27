//
//  InequalitySign.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

enum InequalitySign: String {
    case LessThan = "<"
    case LessThanOrEqual = "<="
    case Equal = "="
    case GreaterThanOrEqual = ">="
    case GreaterThan = ">"
    
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