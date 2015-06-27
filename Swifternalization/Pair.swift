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
        findExpression()
    }
    
    mutating func findExpression() {
        self.expression = Expression.expressionFromString(key)
    }
}

extension Pair: Printable {
    var description: String {
        return "\(key) = \(value)"
    }
}
