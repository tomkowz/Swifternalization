//
//  Pairs.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

struct Pair {
    let key: Key
    let value: Value
    
    private var expression: String? = nil
    
    var hasExpression: Bool { return expression != nil }
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
        findExpression()
    }
    
    mutating func findExpression() {
        let regexp = NSRegularExpression(pattern: "{(.*)?}", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        if let match = regexp?.firstMatchInString(key, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, count(key))) {
            let startRange = advance(key.startIndex, match.range.location)
            let endRange = advance(startRange, match.range.length)
            self.expression = key.substringWithRange(Range(start: startRange, end: endRange))
        }
    }
}

extension Pair: Printable {
    var description: String {
        return "\(key) = \(value)"
    }
}



///

//"%d cars" = "%d samochodów";
//
//"welcome" = "cześć";
//
//"things" = "rzeczy";
//
//"%d cars{1}" = "%d samochód";
//"%d cars{2-4}" = "%d samochody";
//"%d cars{5-21}" = "%d samochodów";
//"%d cars{22-24}" = "%d samochody";
//"%d cars{25-31}" = "%d samochodów";
//"%d cars{32-34}" = "%d samochody";