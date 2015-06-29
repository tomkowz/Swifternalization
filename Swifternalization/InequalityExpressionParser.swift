//
//  InequalityExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class InequalityExpressionParser: ExpressionParser {
    let pattern: ExpressionPattern
    
    required init(_ pattern: ExpressionPattern) {
        self.pattern = pattern
    }
    
    func parse() -> ExpressionMatcher? {
        if let valueType = valueType(),
            let sign = sign(),
            let value = value() {
                return InequalityExpressionMatcher(valueType: valueType, sign: sign, value: value)
        } else {
            return nil
        }
    }
    
    // Get value type: parses to find e.g. %d - Int is only one supported for now.
    private func valueType() -> ValueType? {
        return getValueType("(?<=^ie:)\\S{2}", failureMessage: "Cannot find value type [%d]")
    }
    
    // Get mathematical inequality sign
    private func sign() -> InequalitySign? {
        return getSign("(<=|<|=|>=|>)", failureMessage: "Cannot find any sign")
    }
    
    // Get value from the pattern
    private func value() -> Int? {
        return getValue("(\\d+)|(-\\d+)", failureMessage: "Cannot find any value")
    }
    
    
    // MARK: Helpers
    func getValue(regex: String, failureMessage: String) -> Int? {
        if let value = Regex.firstMatchInString(pattern, pattern: regex)?.toInt() {
            return value
        } else {
            println("\(failureMessage), pattern: \(pattern), regex: \(regex)")
            return nil
        }
    }
    
    func getSign(regex: String, failureMessage: String) -> InequalitySign? {
        if let rawValue = Regex.firstMatchInString(pattern, pattern: regex),
            let sign = InequalitySign(rawValue: rawValue) {
                return sign
        } else {
            println("\(failureMessage), pattern: \(pattern), regex: \(regex)")
            return nil
        }
    }
    
    func getValueType(regex: String, failureMessage: String) -> ValueType? {
        if let rawValue = Regex.firstMatchInString(pattern, pattern: regex),
            let value = ValueType(rawValue:rawValue) {
                return value
                
        } else {
            println("\(failureMessage), pattern: \(pattern), regex: \(regex)")
            return nil
        }
    }
}