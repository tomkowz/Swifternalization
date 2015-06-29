//
//  Swifternalization.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

public typealias I18n = Swifternalization



typealias Language = String

public class Swifternalization {
    
    private let bundle: NSBundle
    
    // Translable from base Localizable.strings file
    private var basePairs = [TranslatablePair]()
    
    // Translable airs from preferred language Localizable.strings file
    private var preferredPairs = [TranslatablePair]()
    
    /** 
    Initialize with bundle when Localizable.strings file is located.
    This method return instance of the class but you don't need it.
    Shared instance is automatically set so you can start using class method.
    
    It get the Localizable.strings file version based on language set on the device using 'preferredLocations' property of NSBUndle.
    If version for specific language isn't found it tries with Base version.
    */
    public init(bundle: NSBundle) {
        self.bundle = bundle
        Swifternalization.setSharedInstance(self)
        load()
    }
    
    
    // MARK: Private
    private func load() {
        // Get language
        let language = getPreferredLanguage()
        
        // Get expressions pairs from Expressions.strings files
        let expPairsDicts = LocalizableFilesLoader(bundle).loadContentFromBaseAndPreferredLanguageFiles(.Expressions, language: language)
        
        // Get shared expressions for Base and preferred language including Framwork's shared expressions
        let sharedExp = SharedExpressionsConfigurator.configureExpressions(expPairsDicts, language: language)
        
        // Get key-value translation pairs from Localizable.strings files
        let translablePairsDicts = LocalizableFilesLoader(bundle).loadContentFromBaseAndPreferredLanguageFiles(.Localizable, language: language)

        basePairs = createTranslablePairs(translablePairsDicts.base, expressions: sharedExp.base)
        preferredPairs = createTranslablePairs(translablePairsDicts.pref, expressions: sharedExp.pref)
    }
    
    private func getPreferredLanguage() -> Language {
        // Get preferred language, the one which is set on user's device
        return bundle.preferredLocalizations.first as! Language
    }
    
    /**
    Enumerate through translation pairs dicts and check if there are some shared patterns that needs to be replaced with custom expressions.
    Next create translable pair with this updated pattern
    */
    private func createTranslablePairs(translationDict: KVDict, expressions: [SharedExpression]) -> [TranslatablePair] {
        var pairs = [TranslatablePair]()
        
        for (tKey, tValue) in translationDict {

            // Check if there is expression in tKey
            if let existingExpression = Expression.expressionFromString(tKey) {
                
                // If there is pattern to replace with original
                if let sharedExpression = expressions.filter({$0.key == existingExpression.pattern}).first {
                    
                    // Create expression with pattern from Expressions.strings and it it is correct use it
                    if let updatedExpression = Expression.expressionFromString("{" + sharedExpression.expression + "}") {
                        
                        // Add translable pair with this new updated expression
                        if let keyWithoutExpression = Regex.firstMatchInString(tKey, pattern: InternalPatterns.KeyWithoutExpression.rawValue) {
                            pairs.append(TranslatablePair(key: keyWithoutExpression + "{" + updatedExpression.pattern + "}", value: tValue))
                            continue
                        }
                    }

                }
            }
            
            pairs.append(TranslatablePair(key: tKey, value: tValue))
        }
        
        return pairs
    }
}

extension Swifternalization {
    
    // Shared instance support
    private struct Static {
        static var instance: Swifternalization? = nil
    }
    
    private class func setSharedInstance(instance: Swifternalization) {
        Static.instance = instance
    }
    
    private class func sharedInstance() -> Swifternalization! {
        return Static.instance
    }
}

/**
Simple key
*/
public extension Swifternalization {
    
    // Return localized string if found, otherwise the passed one
    // key - key in Localizable.strings
    // defaultValue - will be return when nothing can be found
    // otherwise will return key
    public class func localizedString(key: String, defaultValue: String? = nil) -> String {
        if sharedInstance() == nil { return (defaultValue != nil) ? defaultValue! : key }
        
        for TranslatablePair in sharedInstance().preferredPairs.filter({$0.key == key}) {
            return TranslatablePair.value
        }
        
        for TranslatablePair in sharedInstance().basePairs.filter({$0.key == key}) {
            return TranslatablePair.value
        }
        
        return (defaultValue != nil) ? defaultValue! : key
    }
}

/**
Inequality expression keys
*/
public extension Swifternalization {
    public class func localizedExpressionString(key: String, value: String, defaultValue: String? = nil) -> String {
        if sharedInstance() == nil { return (defaultValue != nil) ? defaultValue! : key }
        
        let filter = {(pair: TranslatablePair) -> Bool  in
            return pair.hasExpression == true && pair.keyWithoutExpression == key
        }
        
        // Filter preferred pairs
        for pair in sharedInstance().preferredPairs.filter(filter) {
            if pair.validate(value) {
                return pair.value
            }
        }
        
        // Filter base pairs
        for pair in sharedInstance().basePairs.filter(filter) {
            if pair.validate(value) {
                return pair.value
            }
        }
        
        return (defaultValue != nil) ? defaultValue! : key
    }
}

// Int support
public extension Swifternalization {
    public class func localizedExpressionString(key: String, value: Int, defaultValue: String? = nil) -> String {
        return self.localizedExpressionString(key, value: "\(value)", defaultValue: defaultValue)
    }
}
