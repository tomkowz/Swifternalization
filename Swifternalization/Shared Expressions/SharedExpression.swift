//
//  SharedExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

// rules for cardinals: http://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html

protocol SharedExpressionProtocol {
    static func allExpressions() -> [SharedExpression]
}

struct SharedExpression {
    let key: Key
    let expression: ExpressionPattern
    
    init(k: Key, e: ExpressionPattern) {
        self.key = k
        self.expression = e
    }
}