//
//  SharedExpressionsConfigurator.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Class is responsible for overriding existing shared expressions with these ones existing in Expressions.strings files.
Framework specifies some shared expressions. If this expressions are overriden by developer in Expressions.strings file these from the files will be used instead.
*/
class SharedExpressionsConfigurator {
    class func configureExpressions(dicts: BasePrefDicts, language: Language) -> (base: [SharedExpression], pref: [SharedExpression]) {
        // Load country specific expressions
        var countryExpressions = [SharedExpression]()
        
        switch language {
        case "pl": countryExpressions = SharedPolishExpression.allExpressions()
        
        default:
            break
        }
        
        let baseExpressions = SharedBaseExpression.allExpressions()
        
        // add expressions that are not in country expressions
        for exp in baseExpressions {
            if countryExpressions.filter({$0.key == exp.key}).first == nil {
                countryExpressions.append(exp)
            }
        }
        
        let baseSharedExp = expressionsWith(baseExpressions, expressionsDict: dicts.base)
        let prefSharedExp = expressionsWith(countryExpressions, expressionsDict: dicts.pref)
        
        return (baseSharedExp, prefSharedExp)
    }
    
    class func expressionsWith(sharedExpressions: [SharedExpression], expressionsDict: KVDict) -> [SharedExpression] {
        var result = [SharedExpression]()
        
        // Add all expressions from Expressions.strings file
        for (eKey, eValue) in expressionsDict {
            result.append(SharedExpression(k: eKey, e: eValue))
        }
        
        // Check if there are global expression which are not added (their keys) in Expressions.strings
        for expression in sharedExpressions {
            if result.filter({$0.key == expression.key}).first == nil {
                result.append(expression)
            }
        }
        
        return result
    }
}