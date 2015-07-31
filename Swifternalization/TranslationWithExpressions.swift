//
//  TranslationWithExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents translation with expressions.
*/
struct TranslationWithExpressions: TranslationType {
    /// Key that identifies a translation.
    let key: String
    
    /// Expressions that are related to a translation.
    let expressions: [ExpressionType]
    
    func validate(text: String, length: Int?) {
        for expression in expressions {
            // Do something
        }
    }
}
