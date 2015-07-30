//
//  SimpleExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class SimpleExpression: ExpressionType {
    /// Pattern of expression.
    let pattern: String

    /// A localized value.
    let localizedValue: String

    init(pattern: String, localizedValue: String) {
        self.pattern = pattern
        self.localizedValue = localizedValue
    }
    
    /**
    Validates passed string.
    
    :param: text A text to be validated.
    :returns: True if text matches validation rules, otherwise false.
    */
    func validate(text: String) -> Bool {
        return true
    }
}
