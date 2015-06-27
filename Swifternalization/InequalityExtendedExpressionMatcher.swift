//
//  InequalityExtendedExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

struct InequalityExtendedExpressionMatcher: ExpressionMatcher {
    
    let leftMatcher: InequalityExpressionMatcher
    let rightMatcher: InequalityExpressionMatcher
    
    init(left: InequalityExpressionMatcher, right: InequalityExpressionMatcher) {
        self.leftMatcher = left
        self.rightMatcher = right
    }
    
    func validate(val: String) -> Bool {
        return leftMatcher.validate(val) && rightMatcher.validate(val)
    }
}