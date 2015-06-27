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
    
    private func firstValue() -> Int {
        return Regex.firstMatchInString(expression, pattern: "(?<=^iex:)\\d+")!.toInt()!
    }
    
    private func firstSign() -> InequalitySign {
        return InequalitySign(rawValue:Regex.firstMatchInString(expression, pattern: "(?<=^iex:.)(<=|<|=|>=|>)")!)!.invert()
    }
    
    private func valueType() -> ValueType {
        return ValueType(rawValue: Regex.firstMatchInString(expression, pattern: "(%[d])")!)!
    }
    
    private func secondSign() -> InequalitySign {
        return InequalitySign(rawValue: Regex.firstMatchInString(expression, pattern: "(?<=%[d])(<=|<|=|>=|>)")!)!
    }
    
    private func secondValue() -> Int {
        return Regex.firstMatchInString(expression, pattern: "(?<=%[d]<=|<|=|>=|>)(\\d+)")!.toInt()!
    }    
}
