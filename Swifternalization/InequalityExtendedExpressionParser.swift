//
//  InequalityExtendedExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Parses inequality extended expressions. `iex:5<%d<10`.
*/
class InequalityExtendedExpressionParser: InequalityExpressionParser {
    
    /**
    Method parses `pattern` passed in initialization.
    
    :returns: `ExpressionMatcher` or nil if `pattern` cannot be parsed.
    */
    override func parse() -> ExpressionMatcher? {
        if let valueType = valueType(),
            var firstSign = firstSign(),
            let firstValue = firstValue(),
            let secondSign = secondSign(),
            let secondValue = secondValue() {
                
                // Invert first sign if number is positive or zero
                firstSign = firstValue < 0 ? firstSign : firstSign.invert()
                
                let leftMatcher = InequalityExpressionMatcher(valueType: valueType, sign: firstSign, value: firstValue)
                let rightMatcher = InequalityExpressionMatcher(valueType: valueType, sign: secondSign, value: secondValue)
                return InequalityExtendedExpressionMatcher(left: leftMatcher, right: rightMatcher)
        }
        
        return nil
    }
    
    // MARK: Private
    
    /**
    Method parses first value.
    
    :returns: `Int` or nil if value cannot be found.
    */
    private func firstValue() -> Int? {
        return getValue("(?<=^iex:)((\\d+)|(-\\d+))", failureMessage: "Cannot find first value")
    }
    
    
    /**
    Method parses first sign.
    
    :returns: inequality sign or nil if sign cannot be found.
    */
    private func firstSign() -> InequalitySign? {
        return getSign("(?<=^iex:-.|^iex:.)(<=|<|=|>=|>)", failureMessage: "Cannot find first sign")
    }
    
    /**
    Method parses value type.
    
    :returns: A `ValueType` or nil if value cannot be found.
    */
    private func valueType() -> ValueType? {
        return getValueType("(%[d])", failureMessage: "Cannot find type of value [%d]")
    }
    
    /**
    Method parses second sign of expression.
    
    :returns: A second sign or nil if sign cannot be found.
    */
    private func secondSign() -> InequalitySign? {
        return getSign("(?<=%[d])(<=|<|=|>=|>)", failureMessage: "Cannot find second sign")
    }
    
    /**
    Method parses second value of expression.
    
    :returns: A second value or nil if value cannot be found.
    */
    private func secondValue() -> Int? {
        return getValue("(?<=%[d]<=|<|=|>=|>)((\\d+)|(-\\d+))", failureMessage: "Cannot find second value")
    }
}
