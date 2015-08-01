//
//  ExpressionPatternType.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/** 
Supported expression types.
*/
enum ExpressionPatternType: String {
    /** 
    Works with Int/Float, e.g. `x<5`, `x=3`, `x<4.5`.
    */
    case Inequality = "ie"
    
    /** 
    Works on Int/Float only, e.g. `4<x<10`, `1<=x<18`, `1.3<=x<15.4`.
    */
    case InequalityExtended = "iex"
    
    /** 
    Regular expression, e.g. `[02-9]+`.
    */
    case Regex = "exp"
}
