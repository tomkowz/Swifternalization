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
            let firstSign = firstSign(),
            let firstValue = firstValue(),
            let secondSign = secondSign(),
            let secondValue = secondValue() {
                let leftMatcher = InequalityExpressionMatcher(valueType: valueType, sign: firstSign.invert(), value: firstValue)
                let rightMatcher = InequalityExpressionMatcher(valueType: valueType, sign: secondSign, value: secondValue)
                return InequalityExtendedExpressionMatcher(left: leftMatcher, right: rightMatcher)
        }
        
        return nil
    }
    

    private func firstValue() -> Int? {
        return getValue("(?<=^iex:)\\d+", failureMessage: "Cannot find first value")
    }
    
    private func firstSign() -> InequalitySign? {
        return getSign("(?<=^iex:.)(<=|<|=|>=|>)", failureMessage: "Cannot find first sign")
    }
    
    private func valueType() -> ValueType? {
        return getValueType("(%[d])", failureMessage: "Cannot find type of value [%d]")
    }
    
    private func secondSign() -> InequalitySign? {
        return getSign("(?<=%[d])(<=|<|=|>=|>)", failureMessage: "Cannot find second sign")
    }
    
    private func secondValue() -> Int? {
        return getValue("(?<=%[d]<=|<|=|>=|>)(\\d+)", failureMessage: "Cannot find second value")
    }
}
