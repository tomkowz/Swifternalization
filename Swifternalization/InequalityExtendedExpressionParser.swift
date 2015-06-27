//
//  InequalityExtendedExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class InequalityExtendedExpressionParser: ExpressionParser {
    
    private let expression: String
    
    init(_ expression: String) {
        self.expression = expression
    }
    
    func parse() -> ExpressionMatcher {
        let leftMatcher = InequalityExpressionMatcher(valueType: valueType(), sign: firstSign(), value: firstValue())
        let rightMatcher = InequalityExpressionMatcher(valueType: valueType(), sign: secondSign(), value: secondValue())
        return InequalityExtendedExpressionMatcher(left: leftMatcher, right: rightMatcher)
    }
    
    // Get first number
    private func firstValue() -> Int {
        return Regex.firstMatchInString(expression, pattern: "(?<=^iex:)\\d+")!.toInt()!
    }
    
    // Get first inequality sign - this one is inverted to fit the logic in the pattern
    private func firstSign() -> InequalitySign {
        return InequalitySign(rawValue:Regex.firstMatchInString(expression, pattern: "(?<=^iex:.)(<=|<|=|>=|>)")!)!.invert()
    }
    
    // Get value type, Int.
    private func valueType() -> ValueType {
        return ValueType(rawValue: Regex.firstMatchInString(expression, pattern: "(%[d])")!)!
    }
    
    // Get second inequality sign
    private func secondSign() -> InequalitySign {
        return InequalitySign(rawValue: Regex.firstMatchInString(expression, pattern: "(?<=%[d])(<=|<|=|>=|>)")!)!
    }
    
    // Get second value
    private func secondValue() -> Int {
        return Regex.firstMatchInString(expression, pattern: "(?<=%[d]<=|<|=|>=|>)(\\d+)")!.toInt()!
    }    
}
