//
//  RegexExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Parser that parses expressions that contains regular expressions.
*/
class RegexExpressionParser: ExpressionParser {
    /** 
    Expression pattern - regular expression.
    */
    let pattern: ExpressionPattern

    /**
    Parser initializer.
    
    :param: pattern Expression pattern that should be regular expression.
    */
    required init(_ pattern: ExpressionPattern) {
        self.pattern = pattern
    }

    /**
    Parses pattern passed during initialization and returns 
    expression matcher if pattern is valid.
    
    :returns: `ExpressionMatcher` object or nil if pattern is not valid.
    */
    func parse() -> ExpressionMatcher? {
        if let regex = regexPattern() {
            return RegexExpressionMatcher(pattern: regex)
        } else {
            return nil
        }
    }
    
    /**
    Get regular expression pattern from pattern passed during initialization.
    
    :returns: `RegexPattern` or nil when there is no regular expression 
            in the pattern.
    */
    private func regexPattern() -> RegexPattern? {
        if let regex = Regex.firstMatchInString(pattern, pattern: "(?<=^\(ExpressionPatternType.Regex.rawValue):).*") {
            return regex
        } else {
            print("Cannot find any regular expression, pattern: \(pattern)")
            return nil
        }
    }
}