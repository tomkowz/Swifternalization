//
//  RegexExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class RegexExpressionParser: ExpressionParser {
    
    private let expression: String
    
    init(_ expression: String) {
        self.expression = expression
    }
    
    func parse() -> ExpressionMatcher {
        return RegexExpressionMatcher(pattern: regexPattern())
    }
    
    // Get regular expression from the pattern
    private func regexPattern() -> RegexPattern {
        return Regex.firstMatchInString(expression, pattern: "(?<=^exp:).*")!
    }
}