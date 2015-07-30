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
    class func processTrnslations(baseTranslations: [LoadedTranslation], preferedLanguageTranslations: [LoadedTranslation], sharedExpressions: [SharedExpression]) -> [TranslationType] {
        
        // Find those base translations that are not contained in prefered 
        // language translations.
        var uniqueBaseTranslations = baseTranslations
        if preferedLanguageTranslations.count > 0 {
            uniqueBaseTranslations = baseTranslations.filter({
                let base = $0
                return preferedLanguageTranslations.filter({$0.key == base.key}).count == 0
            })
        }
        
        let translationsReadyToProcess = preferedLanguageTranslations + uniqueBaseTranslations
        
        // Create array with translations. Array is just a map created from 
        // loaded translations. There are few types of translations and 
        // expressions used by the framework.
        return translationsReadyToProcess.map({
            switch $0.type {
            case .Simple:
                // Simple translation with key and value.
                let value = $0.content[$0.key] as! String
                return TranslationWithExpressions(key: $0.key, expressions: [SimpleExpression(pattern: $0.key, localizedValue: value)])
                
            case .WithExpressions:
                // Translation that contains expression.
                // Every time when new expressions is about to create, 
                // the shared expressions are filtered to get expression that 
                // matches key and if there is a key it is replaced with real
                // expression pattern.
                var expressions = [ExpressionType]()
                for (key, value) in $0.content as! Dictionary<String, String> {
                    let pattern = sharedExpressions.filter({$0.identifier == key}).first?.pattern ?? key
                    expressions.append(SimpleExpression(pattern: pattern, localizedValue: value))
                }
                return TranslationWithExpressions(key: $0.key, expressions: expressions)
                
            case .WithLengthVariations:
                // Translation contains length expressions like @100, @200, etc.
                var lengthVariations = [LengthVariation]()
                for (key, value) in $0.content as! Dictionary<String, String> {
                    lengthVariations.append(LengthVariation(length: self.parseNumberFromLengthVariation(key), value: value))
                }
                return TranslationWithExpressions(key: $0.key, expressions: [LengthVariationExpression(pattern: $0.key, variations: lengthVariations)])

            case .WithExpressionsAndLengthVariations:
                // The most advanced translation type. It contains expressions 
                // that contain length variations. THe job done here is similar 
                // to the one in .WithExpressions and .WithLengthVariations
                // cases. key is filtered in shared expressions to get one of 
                // shared expressions and then method builds array of variations.
                var expressions = [ExpressionType]()
                for (key, value) in $0.content as! Dictionary<String, Dictionary<String, String>> {
                    let pattern = sharedExpressions.filter({$0.identifier == key}).first?.pattern ?? key
                    
                    var lengthVariations = [LengthVariation]()
                    for (lvKey, lvValue) in value as Dictionary<String, String> {
                        lengthVariations.append(LengthVariation(length: self.parseNumberFromLengthVariation(lvKey), value: lvValue))
                    }
                    expressions.append(LengthVariationExpression(pattern: pattern, variations: lengthVariations))
                }
                return TranslationWithExpressions(key: $0.key, expressions: expressions)
            }
        })
    }
    
    /**
    Parses nubmer from length variation key.
    
    :param: string A string that contains length variation string like @100.
    :returns: A number parsed from the string.
    */
    private class func parseNumberFromLengthVariation(string: String) -> Int {
        return (Regex.matchInString(string, pattern: "@(\\d+)", capturingGroupIdx: 1)! as NSString).integerValue
    }
}
