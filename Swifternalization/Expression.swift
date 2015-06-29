//
//  Expression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

enum ExpressionType: String {
    // works on Int only, e.g. %d<5, %d=3
    case Inequality = "ie"
    
    // works on Int only, e.g. 4<%d<10, 1<=%d<18
    case InequalityExtended = "iex"
    
    // regular expression, e.g. [02-9]+
    case Regex = "exp"
}

typealias ExpressionPattern = String

/**
The class represents single expression that is added in curly brackets in
key inside Localizable.strings file or as a value in Expressions.strings.

It is able to validate passed strings using internal expression matcher.
*/
class Expression {
    let pattern: ExpressionPattern
    
    private var type: ExpressionType!
    private var matcher: ExpressionMatcher!
    
    // Returns pattern if exists in string
    class func parseExpressionPattern(str: String) -> ExpressionPattern? {
        if let pattern = Regex.firstMatchInString(str, pattern: InternalPatterns.Expression.rawValue) {
            return pattern
        } else {
            println("Cannot get expression pattern from string: \(str).")
            return nil
        }
    }
    
    // It tries to parse string and if there is some expression in curly 
    // brackets it will try to match it to some of the supported ExpressionTypes.
    class func expressionFromString(str: String) -> Expression? {
        if let pattern = parseExpressionPattern(str) {
            return Expression(pattern: pattern)
        }
        return nil
    }
    
    init?(pattern: ExpressionPattern) {
        // pattern is assigned even if init fails because of Swift/compiler bug.
        self.pattern = pattern

        if let type = Expression.getExpressionType(pattern) {
            self.type = type
            
            // build correct expression matcher
            buildMatcher()
        } else {
            println("Cannot create expression with pattern: \(pattern).")
            return nil
        }
    }
    
    func validate(value: String) -> Bool {
        return matcher.validate(value)
    }
    
    
    // MARK: Private
    private func buildMatcher() {
        switch (type as ExpressionType) {
        case .Inequality:
            matcher = InequalityExpressionParser(pattern).parse()
            
        case .InequalityExtended:
            matcher = InequalityExtendedExpressionParser(pattern).parse()
            
        case .Regex:
            matcher = RegexExpressionParser(pattern).parse()
        }
    }
    
    private class func getExpressionType(pattern: ExpressionPattern) -> ExpressionType? {
        if let result = Regex.firstMatchInString(pattern, pattern: InternalPatterns.ExpressionType.rawValue) {
            return ExpressionType(rawValue: result)
        }
        return nil
    }
}
