//
//  LoadedTranslationsProcessor.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Translation processor which takes loaded translations and process them to make
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
    
    :param: baseTranslations An array of base translations.
    :param: prerferedLanguageTranslations An array of prefered language translations.
    :param: sharedExpressions An array of shared expressions.
    */
    class func processTranslations(_ baseTranslations: [LoadedTranslation], preferedLanguageTranslations: [LoadedTranslation], sharedExpressions: [SharedExpression]) -> [Translation] {
        /*
        Find those base translations that are not contained in prefered language 
        translations.
        */
        var uniqueBaseTranslations = baseTranslations
        if preferedLanguageTranslations.count > 0 {
            uniqueBaseTranslations = baseTranslations.filter({
                let base = $0
                return preferedLanguageTranslations.filter({$0.key == base.key}).count == 0
            })
        }
        
        let translationsReadyToProcess = preferedLanguageTranslations + uniqueBaseTranslations
        /*
        Create array with translations. Array is just a map created from loaded 
        translations. There are few types of translations and expressions used 
        by the framework.
        */
        return translationsReadyToProcess.map({
            switch $0.type {
            case .simple:
                // Simple translation with key and value.
                let value = $0.content[$0.key] as! String
                return Translation(key: $0.key, expressions: [Expression(pattern: $0.key, value: value)])
                
            case .withExpressions:
                /*
                Translation that contains expression.
                Every time when new expressions is about to create, the shared 
                expressions are filtered to get expression that matches key and 
                if there is a key it is replaced with real expression pattern.
                */
                var expressions = [Expression]()
                for (key, value) in $0.content as! Dictionary<String, String> {
                    let pattern = sharedExpressions.filter({$0.identifier == key}).first?.pattern ?? key
                    expressions.append(Expression(pattern: pattern, value: value))
                }
                return Translation(key: $0.key, expressions: expressions)
                
            case .withLengthVariations:
                // Translation contains length expressions like @100, @200, etc.
                var lengthVariations = [LengthVariation]()
                for (key, value) in $0.content as! Dictionary<String, String> {
                    lengthVariations.append(LengthVariation(width: self.parseNumberFromLengthVariation(key), value: value))
                }
                return Translation(key: $0.key, expressions: [Expression(pattern: $0.key, value: lengthVariations.last!.value, lengthVariations: lengthVariations)])

            case .withExpressionsAndLengthVariations:
                /*
                The most advanced translation type. It contains expressions
                that contain length variations or just simple expressions.
                THe job done here is similar to the one in .WithExpressions
                and .WithLengthVariations cases. key is filtered in shared
                expressions to get one of shared expressions and then method
                builds array of variations.
                */
                var expressions = [Expression]()
                for (key, value) in $0.content {
                    let pattern = sharedExpressions.filter({$0.identifier == key}).first?.pattern ?? key
                    if value is Dictionary<String, String> {
                        var lengthVariations = [LengthVariation]()
                        for (lvKey, lvValue) in value as! Dictionary<String, String> {
                            lengthVariations.append(LengthVariation(width: self.parseNumberFromLengthVariation(lvKey), value: lvValue))
                        }
                        expressions.append(Expression(pattern: pattern, value: lengthVariations.last!.value, lengthVariations: lengthVariations))
                    } else if value is String {
                        expressions.append(Expression(pattern:pattern, value: value as! String))
                    }
                }
                return Translation(key: $0.key, expressions: expressions)
            }
        })
    }
    
    /**
    Parses nubmer from length variation key.
    
    :param: string A string that contains length variation string like @100.
    :returns: A number parsed from the string.
    */
    private class func parseNumberFromLengthVariation(_ string: String) -> Int {
        return (Regex.matchInString(string, pattern: "@(\\d+)", capturingGroupIdx: 1)! as NSString).integerValue
    }
}
