//
//  ExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

/**
    Protocol that is the base protocol to conform for expression matchers like 
    `InequalityExpressionMatcher` or `RegexExpressionMatcher`.
*/
protocol ExpressionMatcher {
    /**
    Method used to validate passed `val` parameter.

    :param: val string value that will be used to match expression.
    :returns: `true` if value matches expression, otherwise `false`.
    */
    func validate(val: String) -> Bool
}