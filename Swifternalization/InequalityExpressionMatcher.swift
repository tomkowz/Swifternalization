//
//  InequalityExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Struct that is used to validate inequality expressions.
*/
struct InequalityExpressionMatcher: ExpressionMatcher {
    
    /** 
    `InequalitySign` of expression to be matched.
    */
    let sign: InequalitySign
    
    /** 
    A value that will be used during validation to compare to passed one.
    */
    let value: Double
        
    /**
    Initialization method takes few parameters that has been fetched from
    expression parser.

    :param: sign `InequalitySign` parsed from expression pattern.
    :param: value value that will be used to compare.

    :returns: inquality expression matcher.
    */
    init(sign: InequalitySign, value: Double) {
        self.sign = sign
        self.value = value
    }
    
    /**
    Method used to validate passed value and check if it match to expression.
    
    :param: val value passed as `String` that will be converted to `Double`.
    :returns: `true` if `val` match expression pattern, otherwise `false`.
    */
    func validate(_ val: String) -> Bool {
        let n = NSString(string: val).doubleValue
        switch sign {
        case .LessThan: return n < value
        case .LessThanOrEqual: return n <= value
        case .Equal: return n == value
        case .GreaterThanOrEqual: return n >= value
        case .GreaterThan: return n > value
        }
    }
}
