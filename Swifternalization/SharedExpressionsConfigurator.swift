//
//  SharedExpressionsConfigurator.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Swifternalization contains some built-in country-related shared expressions.
Developer can create its own expressions in Expressions.strings file for 
base and preferred language version of the file.

The class is responsible for proper loading the built-in shared ones and 
those loaded from project's files. It handles overriding of built-in and loads 
those from Base and preferred language version.

It always load base expressions, then looking for language specific.
If in Base file are some expressions that overrides built-in, that's fine 
the class adds or developer's custom expressions and add only those of built-in 
that are not contained in the Base.

The same is for preferred languages but also here what is important is that 
at first preferred language file expressions are loaded, then if something 
different is defined in Base it will be also loaded and then the built-in 
expression that differs.
*/
class SharedExpressionsConfigurator {
    
    /**
    Method takes expression for both Base and preferred language localizations 
    and also internally loads built-in expressions, combine them and returns 
    tuple with expressions for Base and another array for preferred language 
    localization.
    
    :param: dicts A `BasePrefDicts` tuple that contains two dicts of 
            shared expressions for Base and preferred language localization.
    :param: language A preferred user's language.
    :returns: Tuple with arrays of shared expressions for Base and preferred 
            language localizations.
    */
    class func configureExpressions(dicts: BasePrefDicts, language: Language) -> (base: [SharedExpression], pref: [SharedExpression]) {
        // Convert loaded expressions dicts to SharedExpression arrays
        let loadedBaseExpressions = convert(dicts.base)
        let loadedPrefExpressions = convert(dicts.pref)
        
        
        // Load country specific expressions from Expressions.strings
        var prefBuiltIn = loadBuiltInExpressions(language)
        
        // Get base built-in expressions
        let baseBuiltIn = SharedBaseExpression.allExpressions()
    
        // Add unique expressions from Base to language specific (preferred)
        mergeExpressions(&prefBuiltIn, additional: baseBuiltIn)
        
        
        // Add built-in expressions to Base expressions from Expressions.strings
        let resultBaseExpressions = mergeExpressions(loadedBaseExpressions, additional: baseBuiltIn)
        
        // Add built-in preferred language expressions to those from 
        // Expressions.strings
        var resultPrefExpressions = mergeExpressions(loadedPrefExpressions, additional: prefBuiltIn)
        
        // Add those from result of base expressions to result of preferred 
        // language expressions
        mergeExpressions(&resultPrefExpressions, additional: resultBaseExpressions)
        
        
        return (resultBaseExpressions, resultPrefExpressions)
    }
    
    
    // MARK: Private
    
    /**
    Converts dictionary with expressions to array of `SharedExpression` objects.
    
    :param: expressionsDict Dictionary with key-value pair of expression 
            from Expressions.strings.
    :returns: Array of `SharedExpression` objects.
    */
    private class func convert(expressionsDict: KVDict) -> [SharedExpression] {
        var result = [SharedExpression]()
        for (key, pattern) in expressionsDict {
            result.append(SharedExpression(key: key, pattern: pattern))
        }
        return result
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
    
    /**
    Method that merges expressions. It takes two arrays, one is `source` and one 
    is `additional`. If the `source` does not contain some expression from 
    `additional` array this expression will be added to the `source`.
    
    :param: source A source array with expressions.
    :param: additional Array with additional expressions that may or may not 
            be added to `source` array.
    :returns: Array with expressions that contains all elements from `source` 
            and elements from `additional` that were not in `source`.
    */
    private class func mergeExpressions(var source: [SharedExpression], additional: [SharedExpression]) -> [SharedExpression] {
        for additionalExp in additional {
            if source.filter({$0.key == additionalExp.key}).first == nil {
                source.append(additionalExp)
            }
        }
        return source
    }
    
    /**
    This is just helper method. It does the same like 
    `mergeExpressions(source:additional:)` but this one takes reference to 
    `source` array instead of pasing it by value.
    
    :param: source reference to source array.
    :param: additional Array of additional shared expressions.
    
    :returns: merged array of shared expressions.
    */
    private class func mergeExpressions(inout source: [SharedExpression], additional: [SharedExpression]) -> Void {
        source = mergeExpressions(source, additional: additional)
    }
}