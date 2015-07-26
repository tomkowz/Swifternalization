//
//  TranslationExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class TranslationExpression: TranslationType {
    /// Key that identifies translation.
    let key: String
    
    /// Array with loaded expressions.
    let loadedExpressions: [SimpleExpression]
    
    /// Creates instances of the class.
    init(key: String, loadedExpressions: [SimpleExpression]) {
        self.key = key
        self.loadedExpressions = loadedExpressions
    }
}
