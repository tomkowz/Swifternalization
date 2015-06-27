//
//  Expression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

enum ExpressionType: String {
    case Inequality = "ie:"
}

class Expression {
    private let pattern: String
    private var type: ExpressionType!
    private var matcher: ExpressionMatcher!
    
    static func expressionFromString(str: String) -> Expression? {
        if let pattern = Regex.firstMatchInString(str, pattern: "(?<=\\{)(.+)(?=\\})") {
            return Expression(pattern: pattern)
        }
        return nil
    }
    
    init(pattern: String) {
        self.pattern = pattern
        if let type = parseExpressionType() {
            switch type {
            case .Inequality:
                matcher = InequalityExpressionParser(pattern).parse()
            }
        }
    }
    
    func validate(value: String) -> Bool {
        return matcher.validate(value)
    }
    
    private func parseExpressionType() -> ExpressionType? {
        if let result = Regex.firstMatchInString(pattern, pattern: "^.*:") {
            return ExpressionType(rawValue: result)
        }
        
        return nil
    }
}

extension Expression: Printable {
    var description: String {
        return "\(pattern), \(type), \(matcher.description)"
    }
}