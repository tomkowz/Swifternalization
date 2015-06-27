//
//  InequalityExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

enum ValueType: String {
    case Integer = "%d"
}

enum InequalitySign: String {
    case LessThan = "<"
    case LessThanOrEqual = "<="
    case Equal = "="
    case GreaterThanOrEqual = ">="
    case GreaterThan = ">"
}

class InequalityExpressionParser: ExpressionParser {
    
    private let expression: String
    
    init(_ expression: String) {
        self.expression = expression
    }
    
    func parse() -> ExpressionMatcher {
        return InequalityExpressionMatcher(valueType: valueType(), sign: sign(), value: value())
    }
    
    private func valueType() -> ValueType {
        return ValueType(rawValue: Regex.firstMatchInString(expression, pattern: "(?<=^ie:)\\S{2}")!)!
    }
    
    private func sign() -> InequalitySign {
        return InequalitySign(rawValue: Regex.firstMatchInString(expression, pattern: "(<=|<|=|>=|>)")!)!
    }
    
    private func value() -> Int {
        return Regex.firstMatchInString(expression, pattern: "\\d+")!.toInt()!
    }
}