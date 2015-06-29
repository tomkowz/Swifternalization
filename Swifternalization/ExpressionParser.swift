//
//  ExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

/**
Protocol that is the base for expression parsers like `InequalityExpressionParser`
or `RegexExpressionParser`.

Defines methods and properties that are needed to work as parser.
*/
protocol ExpressionParser {
    /// pattern of expression
    var pattern: ExpressionPattern {get}

    /**
    Method that parse pattern and returns `ExpressionMatcher` object
    if pattern can has been correctly parsed.

    :returns: `ExpressionMatcher` or nil if pattern cannot be parsed.
    */
    func parse() -> ExpressionMatcher?
    
    /**
    Initializer that taeks `ExpressionPattern` as parameter.
    
    :param: pattern `ExpressionPattern` that will be used to create 
            'ExpressionMatcher'.
    */
    init(_ pattern: ExpressionPattern)
}