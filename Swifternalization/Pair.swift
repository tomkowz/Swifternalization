//
//  Pairs.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

typealias Key = String
typealias Value = String

struct Pair {
    let key: Key
    let value: Value
    
    private var expression: Expression? = nil
    
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
    
    var keyWithoutExpression: String {
        if hasExpression == false { return key }
        return Regex.firstMatchInString(key, pattern: "(.*)(?=\\{)")!
    }
}
