//
//  RegexExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class RegexExpressionParser: ExpressionParser {
    let pattern: ExpressionPattern

    required init(_ pattern: ExpressionPattern) {
        self.pattern = pattern
    }

    func parse() -> ExpressionMatcher? {
        if let regex = regexPattern() {
            return RegexExpressionMatcher(pattern: regex)
        } else {
            return nil
        }
    }
    
    // Get regular expression from the pattern
    private func regexPattern() -> RegexPattern? {
        if let regex = Regex.firstMatchInString(pattern, pattern: "(?<=^exp:).*") {
            return regex
        } else {
            println("Cannot find any regular expression, pattern: \(pattern)")
            return nil
        }
    }
}