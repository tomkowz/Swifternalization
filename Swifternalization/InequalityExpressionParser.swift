//
//  InequalityExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Parses inequality expression patterns. e.g. `ie:x=5`.
*/
class InequalityExpressionParser: ExpressionParser {
    /** 
    A pattern of expression.
    */
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
        if let sign = sign(), let value = value() {
            return InequalityExpressionMatcher(sign: sign, value: value)
        }
        return nil
    }
    
    /**
    Get mathematical inequality sign.
    
    :returns: `InequalitySign` or nil if sign cannot be found.
    */
    private func sign() -> InequalitySign? {
        return getSign(ExpressionPatternType.Inequality.rawValue+":x(<=|<|=|>=|>)", failureMessage: "Cannot find any sign", capturingGroupIdx: 1)
    }
    
    /**
    Get value - Double.
    
    :returns: value or nil if value cannot be found
    */
    private func value() -> Double? {
        return getValue(ExpressionPatternType.Inequality.rawValue+":x[^-\\d]{1,2}(-?\\d+[.]{0,1}[\\d]{0,})", failureMessage: "Cannot find any value", capturingGroupIdx: 1)
    }
    
    
    // MARK: Helpers
    
    /**
    Get value with regex and prints failure message if not found.
    
    :param: regex A regular expression.
    :param: failureMessage A message that is printed out in console on failure.
    
    :returns: A value or nil if value cannot be found.
    */
    func getValue(_ regex: String, failureMessage: String, capturingGroupIdx: Int? = nil) -> Double? {
        if let value = Regex.matchInString(pattern, pattern: regex, capturingGroupIdx: capturingGroupIdx) {
            return NSString(string: value).doubleValue
        } else {
            print("\(failureMessage), pattern: \(pattern), regex: \(regex)")
            return nil
        }
    }
    
    /**
    Get sign with regex and prints failure message if not found.
    
    :param: regex A regular expression.
    :param: failureMessage A message that is printed out in console on failure.
    
    :returns: A sign or nil if value cannot be found.
    */
    func getSign(_ regex: String, failureMessage: String, capturingGroupIdx: Int? = nil) -> InequalitySign? {
        if let rawValue = Regex.matchInString(pattern, pattern: regex, capturingGroupIdx: capturingGroupIdx),
            let sign = InequalitySign(rawValue: rawValue) {
                return sign
        } else {
            print("\(failureMessage), pattern: \(pattern), regex: \(regex)")
            return nil
        }
    }
}
