//
//  ExpressionPatternType.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/// Supported expression types
enum ExpressionPatternType: String {
    /// works on Int only, e.g. `x<5`, `x=3`
    case Inequality = "ie"
    
    /// works on Int only, e.g. `4<x<10`, `1<=x<18`
    case InequalityExtended = "iex"
    
    /// regular expression, e.g. `[02-9]+`
    case Regex = "exp"
}