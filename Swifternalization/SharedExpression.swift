//
//  ProcessableSharedExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Protocol that is implemented by classes/structs that contains shared expressions.
Shared expressions are built-in expressions that user can easily use when
localizing app.

Rules: http://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html
*/
protocol SharedExpressionProtocol {
    /** 
    Method returns all expressions for class that conform this protocol
    */
    static func allExpressions() -> [SharedExpression]
}

/**
Represents built-in expression and expressions from Expressions.strings file.
*/
struct SharedExpression {
    /** 
    Identifier of expression.
    */
    let identifier: String
    
    /** 
    Pattern of expression.
    */
    let pattern: String
    
    /** 
    Creates expression.
    */
    init(identifier: String, pattern: String) {
        self.identifier = identifier
        self.pattern = pattern
    }
}