//
//  InequalityExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

struct InequalityExpressionMatcher: ExpressionMatcher {
    // It supports only Int
    let valueType: ValueType
    let sign: InequalitySign
    let value: Int
    
    init(valueType: ValueType, sign: InequalitySign, value: Int) {
        self.valueType = valueType
        self.sign = sign
        self.value = value
    }
    
    func validate(val: String) -> Bool {
        switch valueType {
        case .Integer:
            let n = val.toInt()!
            
            switch sign {
            case .LessThan: return n < value
            case .LessThanOrEqual: return n <= value
            case .Equal: return n == value
            case .GreaterThanOrEqual: return n >= value
            case .GreaterThan: return n > value
            }
        }
    }
}
