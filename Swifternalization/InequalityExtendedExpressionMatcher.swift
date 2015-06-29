//
//  InequalityExtendedExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Validates inequality extended expressions
*/
struct InequalityExtendedExpressionMatcher: ExpressionMatcher {
    
    /// Matcher that validates left side of expressions
    let leftMatcher: InequalityExpressionMatcher
    
    /// Matcher that validates right side of expressions
    let rightMatcher: InequalityExpressionMatcher
    
    /**
    Creates matcher.
    
    :param: left A matcher that validates left side of expression.
    :param: right A matcher that validates right side of expression.
    */
    init(left: InequalityExpressionMatcher, right: InequalityExpressionMatcher) {
        self.leftMatcher = left
        self.rightMatcher = right
    }
    
    /**
    Validates value passed as parameter.
    
    :param: val A value to be matched.
    
    :returns: `true` if value matches, otherwise `false`.
    */
    func validate(val: String) -> Bool {
        return leftMatcher.validate(val) && rightMatcher.validate(val)
    }
}