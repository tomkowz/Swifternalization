//
//  SharedExpressions.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

// rules for cardinals: http://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html

struct SharedExpression {
    let key: Key
    let expression: ExpressionPattern
    
    init(k: Key, e: ExpressionPattern) {
        self.key = k
        self.expression = e
    }
}

protocol SharedExpressionProtocol {
    static func allExpressions() -> [SharedExpression]
}

class GlobalExpressions: SharedExpressionProtocol {
    static func allExpressions() -> [SharedExpression] {
        return [
            // 1
            SharedExpression(k: "one", e: "ie:%d=1"),
            
            // 2, 3, 4...
            SharedExpression(k: ">one", e: "ie:%d>1"),
            
            // 2
            SharedExpression(k: "two", e: "ie:%d=2"),
            
            // 0, 2 ,3...
            SharedExpression(k: "other", e: "exp:(^[^1])|(^\\d{2,})")
        ]
    }
}

class PolishExpressions: SharedExpressionProtocol {
    static func allExpressions() -> [SharedExpression] {
        return [
            /**
            (2-4), (22-24), (32-4), ..., (..>22, ..>23, ..>24)
            
            e.g.
            - 22 samochody, 1334 samochody, 53 samochody
            - 2 minuty, 4 minuty, 23 minuty
            */
            SharedExpression(k: "few", e: "exp:(((?!1).[2-4]{1})$)|(^[2-4]$)"),
            
            /**
            0, (5-9), (10-21), (25-31), ..., (..0, ..1, ..5-9)
            
            e.g.
            - 0 samochodów, 10 samochodów, 26 samochodów, 1147 samochodów
            - 5 minut, 18 minut, 117 minut, 1009 minut
            */
            SharedExpression(k: "many", e: "exp:(.*(?=1).[0-9]$)|(^[05-9]$)|(.*(?!1).[0156789])"),
        ]
    }
}
