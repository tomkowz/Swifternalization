//
//  Expression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

struct Expression {
    let pattern: String
    
    static func expressionFromString(str: String) -> Expression? {
        let regexp = NSRegularExpression(pattern: "(?<=\\{)(.+)(?=\\})", options: .CaseInsensitive, error: nil)
        if let match = regexp?.firstMatchInString(str, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, count(str))) {
            let startRange = advance(str.startIndex, match.range.location)
            let endRange = advance(startRange, match.range.length)
            
            return Expression(pattern: str.substringWithRange(Range(start: startRange, end: endRange)))
        }
        
        return nil
    }
}