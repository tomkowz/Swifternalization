//
//  SimpleExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents simple epxressions that has only pattern and localized value.
*/
struct SimpleExpression: ExpressionType {
    /// Pattern of expression.
    let pattern: String

    /// A localized value.
    let localizedValue: String
}
