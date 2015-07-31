//
//  SimpleExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents simple epxressions.
*/
struct SimpleExpression: ExpressionType {
    /// Pattern of expression.
    let pattern: String

    /// A localized value. If `lengthVariations` array is empty or you want to 
    /// get full localized value use this property.
    let localizedValue: String
    
    /// Array of length variations
    let lengthVariations: [LengthVariation]
    
    // Returns expression object
    init(pattern: String, localizedValue: String, lengthVariations: [LengthVariation] = [LengthVariation]()) {
        self.pattern = pattern
        self.localizedValue = localizedValue
        self.lengthVariations = lengthVariations
    }
}
