//
//  InequalityExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Parses inequality expression patterns. e.g. `ie:%d=5`.
*/
class InequalityExpressionParser: ExpressionParser {
    /// Pattern of expression.
    let pattern: ExpressionPattern
    
    /**
    Initializes parser.
    
    :param: pattern A pattern that will be parsed.
    */
    required init(_ pattern: ExpressionPattern) {
        self.pattern = pattern
    }
    
    /**
    Parses `pattern` passed during initialization.
    
    :returns: `ExpressionMatcher` object or nil if pattern cannot be parsed.
    */
    func parse() -> ExpressionMatcher? {
        if let valueType = valueType(),
            let sign = sign(),
            let value = value() {
                return InequalityExpressionMatcher(valueType: valueType, sign: sign, value: value)
        } else {
            return nil
        }
    }
    
    /**
    Get `ValueType`. Finds only "%d" - Int is only one supported for now.
    
    :returns: `ValueType` or nil if value cannot be found.
    */
    private func valueType() -> ValueType? {
        return getValueType("(?<=^ie:)\\S{2}", failureMessage: "Cannot find value type [%d]")
    }
    
    /**
    Get mathematical inequality sign.
    
    :returns: `InequalitySign` or nil if sign cannot be found.
    */
    private func sign() -> InequalitySign? {
        return getSign("(<=|<|=|>=|>)", failureMessage: "Cannot find any sign")
    }
    
    /**
    Get value - Int.
    
    :returns: value or nil if value cannot be found
    */
    private func value() -> Int? {
        return getValue("(\\d+)|(-\\d+)", failureMessage: "Cannot find any value")
    }
    
    
    // MARK: Helpers
    
    /**
    Get value with regex and prints failure message if not found.
    
    :param: regex A regular expression.
    :param: failureMessage A message that is printed out in console on failure.
    
    :returns: A value or nil if value cannot be found.
    */
    func getValue(regex: String, failureMessage: String) -> Int? {
        if let value = Regex.firstMatchInString(pattern, pattern: regex)?.toInt() {
            return value
        } else {
            println("\(failureMessage), pattern: \(pattern), regex: \(regex)")
            return nil
        }
    }
    
    /**
    Get sign with regex and prints failure message if not found.
    
    :param: regex A regular expression.
    :param: failureMessage A message that is printed out in console on failure.
    
    :returns: A sign or nil if value cannot be found.
    */
    func getSign(regex: String, failureMessage: String) -> InequalitySign? {
        if let rawValue = Regex.firstMatchInString(pattern, pattern: regex),
            let sign = InequalitySign(rawValue: rawValue) {
                return sign
        } else {
            println("\(failureMessage), pattern: \(pattern), regex: \(regex)")
            return nil
        }
    }
    
    /**
    Get value type with regex and prints failure message if not found.
    
    :param: regex A regular expression.
    :param: failureMessage A message that is printed out in console on failure.
    
    :returns: A value type or nil if value cannot be found.
    */
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