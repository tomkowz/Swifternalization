//
//  Pairs.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents key-value pair from Localizable.strings files.
It contains key, value and expression if exists for the key.
It can also validate if text matches expression's requirements.
*/
struct TranslatablePair: KeyValue {
    /// Key from Localizable.strings.
    var key: Key
    
    /// Value from Localizable.strings.
    var value: Value
    
    /// `Expression` which is parsed from `key`.
    var expression: Expression? = nil
    
    /// Tells if pair has `expression` or not.
    var hasExpression: Bool { return expression != nil }
    
    /**
    It returns key without expression pattern.
    If pair has `expression` set to nil it will return `key`.
    If `expression` exist the `key` will be parsed and returned without
    expression pattern.
    */
    var keyWithoutExpression: String {
        if hasExpression == false { return key }
        return Regex.firstMatchInString(key, pattern: InternalPattern.KeyWithoutExpression.rawValue)!
    }
    
    /**
    Creates `TranslatablePair`. It automatically tries to parse
    expression from key - if there is any.

    :param: key A key from Localizable.strings
    :param: value A value from Localizable.strings
    */
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
        parseExpression()
    }

    /// Method parses expression from the `key` property.
    mutating func parseExpression() {
        self.expression = Expression.expressionFromString(key)
    }
    
    /**
    Validates string and check if matches `expression`'s requirements.
    If pair has no expression it return false.
    
    :param: value A value that will be matched.
    :returns: `true` if value matches `expression`, otherwise `false`.
    */
    func validate(value: String) -> Bool {
        if hasExpression == false { return false }
        return expression!.validate(value)
    }
}
