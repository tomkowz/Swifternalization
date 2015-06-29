//
//  RegexExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/// Type that represents pattern with regular expression
internal typealias RegexPattern = String

/**
Matcher is responsible for matching expressions that contains 
regular expressions.
*/
struct RegexExpressionMatcher: ExpressionMatcher {
    /// Expression pattern with regular expression inside.
    let pattern: RegexPattern
    
    /**
    Initializes matcher.
    
    :param: pattern Expression pattern with regexp inside.
    */
    init(pattern: RegexPattern) {
        self.pattern = pattern
    }
    
    /**
    Validates value by matching it to the pattern it contains.
    
    :param: val value that will be matched.
    :returns: `true` if value matches pattern, otherwise `false`.
    */
    func validate(val: String) -> Bool {
        return (Regex.firstMatchInString(val, pattern: pattern) != nil)
    }
}