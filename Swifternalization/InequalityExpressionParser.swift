//
//  InequalityExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class InequalityExpressionParser: ExpressionParser {
    
    private let expression: String
    
    init(_ expression: String) {
        self.expression = expression
    }
    
    func parse() -> ExpressionMatcher {
        return InequalityExpressionMatcher(valueType: valueType(), sign: sign(), value: value())
    }
    
    // Get value type: parses to find e.g. %d - Int is only one supported for now.
    private func valueType() -> ValueType {
        return ValueType(rawValue: Regex.firstMatchInString(expression, pattern: "(?<=^ie:)\\S{2}")!)!
    }
    
    // Get mathematical inequality sign
    private func sign() -> InequalitySign {
        return InequalitySign(rawValue: Regex.firstMatchInString(expression, pattern: "(<=|<|=|>=|>)")!)!
    }
    
    // Get value from the pattern
    private func value() -> Int {
        return Regex.firstMatchInString(expression, pattern: "\\d+")!.toInt()!
    }
}