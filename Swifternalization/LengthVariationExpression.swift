//
//  LengthVariationExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents expression that contains length variations.
*/
struct LengthVariationExpression: ExpressionType {
    /// Pattern of expression.
    let pattern: String
    
    /// Array with length variations.
    let variations: [LengthVariation]
}
