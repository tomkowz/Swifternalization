//
//  SharedExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//


/**
Protocol that is implemented by classes that contains shared expressions.
Shared expressions are built-in expressions that user can easily use when 
localizing app.

Rules: http://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html
*/
protocol SharedExpressionProtocol {
    /// Method returns all expressions for class that conform this protocol
    static func allExpressions() -> [SharedExpression]
}

/**
Represents built-in expression and expressions from Expressions.strings file.
*/
struct SharedExpression {
    /// Key of expression.
    let key: Key
    
    /// Pattern of expression.
    let pattern: ExpressionPattern
    
    /**
    Creates shared expression.
    
    :param: key A key of expression.
    :param: pattern A pattern of expression.
    */
    init(key: Key, pattern: ExpressionPattern) {
        self.key = key
        self.pattern = pattern
    }
}