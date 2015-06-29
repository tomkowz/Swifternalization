//
//  Pairs.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

struct TranslatablePair: KeyValue {
    var key: Key
    var value: Value
    
    var expression: Expression? = nil
    
    var hasExpression: Bool { return expression != nil }
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
        parseExpression()
    }

    mutating func parseExpression() {
        self.expression = Expression.expressionFromString(key)
    }
    
    func validate(value: String) -> Bool {
        if hasExpression == false { return false }
        return expression!.validate(value)
    }
    
    // If entire key is: "cars{ie:%d=1}" it returns "cars"
    var keyWithoutExpression: String {
        if hasExpression == false { return key }
        return Regex.firstMatchInString(key, pattern: InternalPatterns.KeyWithoutExpression.rawValue)!
    }
}
