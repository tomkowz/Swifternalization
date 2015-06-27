//
//  RegexExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

typealias RegexPattern = String

struct RegexExpressionMatcher: ExpressionMatcher {
    let pattern: RegexPattern
    
    init(pattern: RegexPattern) {
        self.pattern = pattern
    }
    
    func validate(val: String) -> Bool {
        return (Regex.firstMatchInString(val, pattern: pattern) != nil)
    }
}