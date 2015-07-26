//
//  ExpressionsProcessor.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Swifternalization contains some built-in country-related shared expressions.
Developer can create its own expressions in expressions.json file for
base and preferred languages.

The class is responsible for proper loading the built-in shared ones and
those loaded from project's files. It handles overriding of built-in and loads
those from Base and preferred language version.

It always load base expressions, then looking for language specific.
If in Base are some expressions that overrides built-ins, that's fine.
The class adds developer's custom expressions and adds only those of built-in
that are not contained in the Base.

The same is for preferred languages but also here what is important is that
at first preferred language file expressions are loaded, then if something
different is defined in Base it will be also loaded and then the built-in
expression that differs.
*/
class SharedExpressionsProcessor {
    
    /**
    Method takes expression for both Base and preferred language localizations
    and also internally loads built-in expressions, combine them and returns 
    expressions for Base and prefered language.
    
    :param: preferedLanguage A user device's language.
    :param: preferedLanguageExpressions Expressions from expressions.json
    :param: baseLanguageExpressions Expressions from base section of 
            expression.json.
    
    :returns: array of shared expressions for Base and preferred language.
    */
    class func processSharedExpression(preferedLanguage: CountryCode, preferedLanguageExpressions: [SharedExpression], baseLanguageExpressions: [SharedExpression]) -> [SharedExpression] {
        /*
        Get unique base expressions that are not presented in prefered language
        expressions. Those from base will be used in a case when programmer 
        will ask for string localization and when there is no such expression
        in prefered language section defined. 

        It means two things:
        1. Programmer make this expression shared through prefered language
        and this is good as base expression.
        2. He forgot to define such expression for prefered language.
        */
        var uniqueBaseExpressions = baseLanguageExpressions
        if preferedLanguageExpressions.count > 0 {
            uniqueBaseExpressions = baseLanguageExpressions.filter({
                let pref = $0
                return preferedLanguageExpressions.filter({$0.identifier == pref.identifier}).count == 0
            })
        }
        
        // Expressions from json files.
        var loadedExpressions = uniqueBaseExpressions + preferedLanguageExpressions

        
        // Load prefered language nad base built-in expressions. Get unique.
        let prefBuiltInExpressions = loadBuiltInExpressions(preferedLanguage)
        let baseBuiltInExpressions = SharedBaseExpression.allExpressions()
        let uniqueBaseBuiltInExpressions = baseBuiltInExpressions.filter({
            let pref = $0
            return prefBuiltInExpressions.filter({$0.identifier == pref.identifier}).count == 0
        })
        
        // Unique built-in expressions made of base + prefered language.
        let builtInExpressions = uniqueBaseBuiltInExpressions + prefBuiltInExpressions
        
        /*
        To get it done we must get only unique built-in expressions that are not 
        in loaded expressions.
        */
        let uniqueBuiltInExpressions = builtInExpressions.filter({
            let builtIn = $0
            return loadedExpressions.filter({$0.identifier == builtIn.identifier}).count == 0
        })
        
        return loadedExpressions + uniqueBuiltInExpressions
    }
    
    /**
    Method loads built-in framework's built-in expressions for specific language.
    
    :param: language A preferred user's language.
    :returns: Shared expressions for specific language. If there is no
    expression for passed language empty array is returned.
    */
    private class func loadBuiltInExpressions(language: Language) -> [SharedExpression] {
        switch language {
        case "pl": return SharedPolishExpression.allExpressions()
        default: return []
        }
    }
}
