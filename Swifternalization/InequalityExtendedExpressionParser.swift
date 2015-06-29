//
//  InequalityExtendedExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class InequalityExtendedExpressionParser: InequalityExpressionParser {
    
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
    private func firstValue() -> Int? {
        return getValue("(?<=^iex:)((\\d+)|(-\\d+))", failureMessage: "Cannot find first value")
    }
    
    private func firstSign() -> InequalitySign? {
        return getSign("(?<=^iex:-.|^iex:.)(<=|<|=|>=|>)", failureMessage: "Cannot find first sign")
    }
    
    private func valueType() -> ValueType? {
        return getValueType("(%[d])", failureMessage: "Cannot find type of value [%d]")
    }
    
    private func secondSign() -> InequalitySign? {
        return getSign("(?<=%[d])(<=|<|=|>=|>)", failureMessage: "Cannot find second sign")
    }
    
    private func secondValue() -> Int? {
        return getValue("(?<=%[d]<=|<|=|>=|>)((\\d+)|(-\\d+))", failureMessage: "Cannot find second value")
    }
}
