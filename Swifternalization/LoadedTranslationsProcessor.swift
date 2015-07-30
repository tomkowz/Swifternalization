//
//  LoadedTranslationsProcessor.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Translation processor that takes loaded translations and process them to make 
them regular translation objects that can be used for further work.
*/
class LoadedTranslationsProcessor {
    
    /**
    Method takes base and prefered language translations and also shared 
    expressions and mix them together. Meaning, It checks which base loaded 
    translations are not contained in prefered language translations and 
    allow them to be used by framework later. It fit to the rule of how system 
    localization mechanism work, that when there is no prefered language 
    translation it takes base one if exists and return translation.
    
    Shared expressions are used to replace shared-expression-keys from loaded 
    translations and use resolved full shared expressions from file with 
    expressions as well as built-in ones. Translations are processed in shared 
    expressions processor.
    */
    class func processTrnslations(baseTranslations: [LoadedTranslation], preferedLanguageTranslations: [LoadedTranslation], sharedExpressions: [SharedExpression]) {
        
        // Find those base translations that are not contained in prefered 
        // language translations.
        var uniqueBaseTranslations = baseTranslations
        if preferedLanguageTranslations.count > 0 {
            uniqueBaseTranslations = baseTranslations.filter({
                let base = $0
                return preferedLanguageTranslations.filter({$0.key == base.key}).count == 0
            })
        }
        
        var translationsReadyToProcess = preferedLanguageTranslations + uniqueBaseTranslations
        var translations: [TranslationType] = translationsReadyToProcess.map({
            switch $0.type {
            case .Simple:
                let value = $0.content[$0.key] as! String
                return SimpleTranslation(key: $0.key, value: value)
                
            case .WithExpressions:
                var expressions = [SimpleExpression]()
                for (key, value) in $0.content as! Dictionary<String, String> {
                    let pattern = sharedExpressions.filter({$0.identifier == key}).first?.pattern ?? key
                    expressions.append(SimpleExpression(pattern: pattern, localizedValue: value))
                }
                return TranslationWithExpressions(key: $0.key, expressions: expressions)
                
                
            // TEMPORARY
            //
            //
            case .WithLengthVariations:
                return SimpleTranslation(key: $0.key, value: $0.content[$0.key]! as! String)

            case .WithExpressionsAndLengthVariations:
                return SimpleTranslation(key: $0.key, value: $0.content[$0.key]! as! String)

            }
        })
    }
}
