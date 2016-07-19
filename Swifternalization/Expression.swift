//
//  Expression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/** 
String that contains expression pattern, e.g. `ie:x<5`, `exp:^1$`.
*/
internal typealias ExpressionPattern = String

/**
This class contains pattern of expression and localized value as well as
length variations if any are associated. During instance initialization pattern 
is analyzed and correct expression matcher is created. If no matcher matches 
the expression pattern then when validating there is only check if passed value 
is the same like pattern (equality). If there is matcher then its internal logic 
validates passed value.
*/
struct Expression {
    /** 
    Pattern of an expression.
    */
    let pattern: ExpressionPattern

    /** 
    A localized value. If length vartiations array is empty or you want to
    get full localized value use this property.
    */
    let value: String
    
    /** 
    Array of length variations.
    */
    let lengthVariations: [LengthVariation]
    
    /** 
    Expression matcher that is used in validation.
    */
    private var expressionMatcher: ExpressionMatcher? = nil
    
    /** 
    Returns expression object.
    */
    init(pattern: String, value: String, lengthVariations: [LengthVariation] = [LengthVariation]()) {
        self.pattern = pattern
        self.value = value
        self.lengthVariations = lengthVariations
        
        /* 
        Create expression matcher if pattern matches some expression type.
        If not matching any expression type then the pattern equality test
        will be perfomed when during validation.
        */
        if let type = getExpressionType(pattern) {
            expressionMatcher = {
                switch (type as ExpressionPatternType) {
                case .Inequality: return InequalityExpressionParser(pattern).parse()
                case .InequalityExtended: return InequalityExtendedExpressionParser(pattern).parse()
                case .Regex: return RegexExpressionParser(pattern).parse()
                }
            }()
        }
    }
    
    /**
    Method that validates passed string.
    
    :param: value value that should be matched
    :returns: `true` if value match expression, otherwise `false`.
    */
    func validate(_ value: String) -> Bool {
        if let matcher = expressionMatcher {
            return matcher.validate(value)
        } else {
            return pattern == value
        }
    }
    
    /**
    Method used to get `ExpressionPatternType` of passed expression pattern.
    
    :param: pattern expression pattern that will be checked.
    :returns: `ExpressionPatternType` if pattern is supported, otherwise nil.
    */
    private func getExpressionType(_ pattern: ExpressionPattern) -> ExpressionPatternType? {
        if let result = Regex.firstMatchInString(pattern, pattern: InternalPattern.ExpressionPatternType.rawValue) {
            return ExpressionPatternType(rawValue: result)
        }
        return nil
    }
}
