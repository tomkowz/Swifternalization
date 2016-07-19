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
struct Translation {
    /// Key that identifies a translation.
    let key: String
    
    /// Expressions that are related to a translation.
    let expressions: [Expression]
    
    /**
    Validates passed `text` and uses `fittingWidth` for getting proper 
    localized string.
    
    :param: text A text that is matched.
    :param: fittingWidth A max width of a screen that text should match.
    :returns: A localized string if any expression validates the `text`,
        otherwise nil.
    */
    func validate(_ text: String, fittingWidth: Int?) -> String? {
        // Find first expression that validates the `text`.
        for expression in expressions {
            if expression.validate(text) {
                /*
                Get the localized value of expression if it match the `text`.
                Check if there is `fittingValue` defined as method argument 
                and if there are some variations in the expression get proper 
                variant for passed length.
                */
                var localizedValue = expression.value
                if fittingWidth != nil && expression.lengthVariations.count > 0 {
                    /*
                    Sort variations in ascending order.
                    If variation width is shorter or equal `fittingWidth`
                    take associated value.
                    */
                    for variation in expression.lengthVariations.sorted(isOrderedBefore: {$0.width < $1.width}) {
                        if variation.width <= fittingWidth! {
                            localizedValue = variation.value
                        }
                    }
                }
                return localizedValue
            }
        }
        return nil
    }
}
