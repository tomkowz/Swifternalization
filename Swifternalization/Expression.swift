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

class Expression {
    let pattern: ExpressionPattern
    
    private var type: ExpressionType!
    private var matcher: ExpressionMatcher!
    
    static func expressionFromString(str: String) -> Expression? {
        if let pattern = Regex.firstMatchInString(str, pattern: InternalPatterns.Expression.rawValue) {
            return Expression(pattern: pattern)
        }
        return nil
    }
    
    init(pattern: ExpressionPattern) {
        self.pattern = pattern
        
        // build correct expression matcher
        if let type = parseExpressionType() {
            switch type {
            case .Inequality:
                matcher = InequalityExpressionParser(pattern).parse()
                
            case .InequalityExtended:
                matcher = InequalityExtendedExpressionParser(pattern).parse()
                
            case .Regex:
                matcher = RegexExpressionParser(pattern).parse()
            }
        }
    }
    
    func validate(value: String) -> Bool {
        return matcher.validate(value)
    }
    
    
    /// Get expression type
    private func parseExpressionType() -> ExpressionType? {
        if let result = Regex.firstMatchInString(pattern, pattern: InternalPatterns.ExpressionType.rawValue) {
            return ExpressionType(rawValue: result)
        }
        return nil
    }
}
