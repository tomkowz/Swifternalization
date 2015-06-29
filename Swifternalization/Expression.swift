//
//  Expression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/// Supported expression types
enum ExpressionType: String {
    /// works on Int only, e.g. `%d<5`, `%d=3`
    case Inequality = "ie"
    
    /// works on Int only, e.g. `4<%d<10`, `1<=%d<18`
    case InequalityExtended = "iex"
    
    /// regular expression, e.g. `[02-9]+`
    case Regex = "exp"
}

/// String that contains expression pattern, e.g. `ie:%d<5`, `exp:^1$`.
internal typealias ExpressionPattern = String

/**
Class represents single expression that is added in curly
brackets inside key in Localizable.strings file or as a value in 
Expressions.strings file.

It is able to validate passed string using internal expression matcher.
*/
class Expression {
    /// Pattern of expression passed during initialization.
    let pattern: ExpressionPattern
        
    /// Type of expression computed based on `pattern`.
    private var type: ExpressionType!
    
    /// Matcher created based on `pattern`.
    private var matcher: ExpressionMatcher!
        
    /**
    Return `ExpressionPattern` object if passed `str` parameter contains
    some pattern. The pattern may not be one of the supported one. 
    If the syntax of the passed string is correct it is treated as pattern.

    :param: str string which may or may not contain a pattern.
    :returns: `ExpressionPattern` object or nil when pattern is not found.
    */
    class func parseExpressionPattern(str: String) -> ExpressionPattern? {
        if let pattern = Regex.firstMatchInString(str, pattern: InternalPattern.Expression.rawValue) {
            return pattern
        } else {
//            println("Cannot get expression pattern from string: \(str).")
            return nil
        }
    }
    
    /**
    Tries to parse passed `str` parameter and created `Expression` from it.
    If passed string contains expression that is supported and inside logic
    compute that this string is some supported pattern an `Expression` object 
    will be returned.

    :param: str string that may or may not contain expression pattern
    :returns: `Expression` object or nil if pattern is not supported.
    */
    class func expressionFromString(str: String) -> Expression? {
        if let pattern = parseExpressionPattern(str) {
            return Expression(pattern: pattern)
        }
        return nil
    }
    
    /**
    Initializer that takes expression pattern. It may fail when expression
    type of passed expression is not supported.

    :param: pattern pattern of expression
    :returns: `Expression` object or nil when pattern is not supported.
    */
    init?(pattern: ExpressionPattern) {
        // pattern is assigned even if init fails because of Swift/compiler bug.
        self.pattern = pattern

        if let type = Expression.getExpressionType(pattern) {
            self.type = type
            
            // build correct expression matcher
            buildMatcher()
            if matcher == nil {
                println("Cannot create expression because expression pattern cannot be parsed: \(pattern)")
                return nil
            }
        } else {
            println("Cannot create expression with pattern: \(pattern).")
            return nil
        }
    }
    
    /**
    Method that validates passed string.

    :param: value value that should be matched
    :returns: `true` if value match expression, otherwise `false`.
    */
    func validate(value: String) -> Bool {
        return matcher.validate(value)
    }
    
    
    // MARK: Private methods
    
    /** 
    Method used to create `ExpressionMatcher` instance that match expression
    pattern of this `Expression` object.
    */
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
    
    /**
    Method used to get `ExpressionType` of passed `ExpressionPattern`. 
    
    :param: pattern expression pattern that will be checked.
    :returns: `ExpressionType` if pattern is supported, otherwise nil.
    */
    private class func getExpressionType(pattern: ExpressionPattern) -> ExpressionType? {
        if let result = Regex.firstMatchInString(pattern, pattern: InternalPattern.ExpressionType.rawValue) {
            return ExpressionType(rawValue: result)
        }
        return nil
    }
}
