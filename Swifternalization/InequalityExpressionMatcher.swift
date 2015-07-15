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

It takes value type, sign of inequality and value from expression pattern 
and then try to use those attributes to validate passed `String` value
that will be converted to `Int`.
*/
struct InequalityExpressionMatcher: ExpressionMatcher {
    
    /// `InequalitySign` of expression to be matched.
    let sign: InequalitySign
    
    /// Value that will be used during validation to compare to passed one.
    let value: Int
        
    /**
    Initialization method takes few parameters that has been fetched from
    expression parser.

    :param: sign `InequalitySign` parsed from expression pattern.
    :param: value value that will be used to compare.

    :returns: inquality expression matcher.
    */
    init(sign: InequalitySign, value: Int) {
        self.sign = sign
        self.value = value
    }
    
    /**
    Method used to validate passed value and check if it match to expression.
    
    :param: val value passed as `String` that will be converted to `Int` later.
    :returns: `true` if `val` match expression pattern, otherwise `false`.
    */
    func validate(val: String) -> Bool {
        let n = val.toInt()!
        
        switch sign {
        case .LessThan: return n < value
        case .LessThanOrEqual: return n <= value
        case .Equal: return n == value
        case .GreaterThanOrEqual: return n >= value
        case .GreaterThan: return n > value
        }
    }
}
