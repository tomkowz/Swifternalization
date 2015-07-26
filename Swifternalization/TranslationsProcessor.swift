//
//  TranslationsProcessor.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class TranslationsProcessor<T where T: TranslationType> {
    class func processTranslations(baseTranslations: [T], preferedLanguageTranslations: [T], sharedExpressions: [SharedExpression]) {
        
        var uniqueBaseTranslations = baseTranslations
        if preferedLanguageTranslations.count > 0 {
            uniqueBaseTranslations = baseTranslations.filter({
                let base = $0
                return preferedLanguageTranslations.filter({$0.key == base.key}).count == 0
            })
        }
        
        var translationsReadyToProcess = preferedLanguageTranslations + uniqueBaseTranslations
        
        var translations: [TranslationType] = translationsReadyToProcess.map({
            if $0 is TranslationSimple {
                return $0
            } else if $0 is ProcessableTranslationExpression {
                let processableTranslation = $0 as! ProcessableTranslationExpression
                
                let expressions = processableTranslation.loadedExpressions.map({ (processableExpr: ProcessableExpressionSimple) -> SimpleExpression in
                    var identifier = processableExpr.identifier
                    if let sharedExpression = sharedExpressions.filter({$0.identifier == identifier}).first {
                        identifier = sharedExpression.pattern
                    }
                    return SimpleExpression(identifier: identifier, value: processableExpr.value)
                })
                
                return TranslationExpression(key: processableTranslation.key, loadedExpressions: expressions)
            }
            
            return $0
        })
    }
}