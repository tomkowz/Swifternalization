//
//  Expression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/// String that contains expression pattern, e.g. `ie:x<5`, `exp:^1$`.
typealias ExpressionPattern = String

/**
Represents simple epxressions.
*/
struct Expression {
    /// Pattern of expression.
    let pattern: String

    /// A localized value. If `lengthVariations` array is empty or you want to 
    /// get full localized value use this property.
    let localizedValue: String
    
    /// Array of length variations
    let lengthVariations: [LengthVariation]
    
    /// Expression matcher that is used in validation
    private var expressionMatcher: ExpressionMatcher? = nil
    
    // Returns expression object
    init(pattern: String, localizedValue: String, lengthVariations: [LengthVariation] = [LengthVariation]()) {
        self.pattern = pattern
        self.localizedValue = localizedValue
        self.lengthVariations = lengthVariations
        
        // Create expression matcher
        if let type = getExpressionType(pattern) {
            switch (type as ExpressionPatternType) {
            case .Inequality:
                expressionMatcher = InequalityExpressionParser(pattern).parse()
                
            case .InequalityExtended:
                expressionMatcher = InequalityExtendedExpressionParser(pattern).parse()
                
            case .Regex:
                expressionMatcher = RegexExpressionParser(pattern).parse()
            }
        }
    }
    
    /**
    Method that validates passed string.
    
    :param: value value that should be matched
    :returns: `true` if value match expression, otherwise `false`.
    */
    func validate(value: String) -> Bool {
        if let matcher = expressionMatcher {
            return matcher.validate(value)
        } else {
            return pattern == value
        }
    }
    
    /**
    Method used to get `ExpressionPatternType` of passed `ExpressionPattern`.
    
    :param: pattern expression pattern that will be checked.
    :returns: `ExpressionPatternType` if pattern is supported, otherwise nil.
    */
    private func getExpressionType(pattern: ExpressionPattern) -> ExpressionPatternType? {
        if let result = Regex.firstMatchInString(pattern, pattern: InternalPattern.ExpressionPatternType.rawValue) {
            return ExpressionPatternType(rawValue: result)
        }
        return nil
    }
}
