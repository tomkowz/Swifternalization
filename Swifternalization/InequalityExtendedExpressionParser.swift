//
//  InequalityExtendedExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Parses inequality extended expressions. `iex:5<x<10`.
*/
class InequalityExtendedExpressionParser: InequalityExpressionParser {
    
    /**
    Method parses `pattern` passed in initialization.
    
    :returns: `ExpressionMatcher` or nil if `pattern` cannot be parsed.
    */
    override func parse() -> ExpressionMatcher? {
        if  var firstSign = firstSign(),
            let firstValue = firstValue(),
            let secondSign = secondSign(),
            let secondValue = secondValue() {
                
                if firstValue < secondValue {
                    firstSign = firstSign.invert()
                }
                                
                let leftMatcher = InequalityExpressionMatcher(sign: firstSign, value: firstValue)
                let rightMatcher = InequalityExpressionMatcher(sign: secondSign, value: secondValue)
                return InequalityExtendedExpressionMatcher(left: leftMatcher, right: rightMatcher)
        }
        
        return nil
    }
    
    // MARK: Private
    
    /**
    Method parses first value.
    
    :returns: `Int` or nil if value cannot be found.
    */
    private func firstValue() -> Double? {
        return getValue(ExpressionPatternType.InequalityExtended.rawValue+":(?<=^iex:)(-?\\d+[.]{0,1}[\\d]{0,})", failureMessage: "Cannot find first value", capturingGroupIdx: 1)
    }
    
    
    /**
    Method parses first sign.
    
    :returns: inequality sign or nil if sign cannot be found.
    */
    private func firstSign() -> InequalitySign? {
        return getSign(ExpressionPatternType.InequalityExtended.rawValue+":-?\\d{0,}[.]?\\d{0,}(<=|<|)", failureMessage: "Cannot find first sign", capturingGroupIdx: 1)
    }
    
    /**
    Method parses second sign of expression.
    
    :returns: A second sign or nil if sign cannot be found.
    */
    private func secondSign() -> InequalitySign? {
        return getSign(ExpressionPatternType.InequalityExtended.rawValue+":[-]?\\d*[.]?\\d*[<=>]{1,2}x(<=|<|)", failureMessage: "Cannot find second sign", capturingGroupIdx: 1)
    }
    
    /**
    Method parses second value of expression.
    
    :returns: A second value or nil if value cannot be found.
    */
    private func secondValue() -> Double? {
        return getValue("(?<=x<=|<)(-?\\d+[.]{0,1}[\\d]{0,})", failureMessage: "Cannot find second value", capturingGroupIdx: 1)
    }
}
