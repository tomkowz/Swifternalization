//
//  Swifternalization.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

public typealias I18N = Swifternalization

typealias Language = String

public class Swifternalization {
    
    typealias KVDict = Dictionary<Key, Value>
    
    private let bundle: NSBundle
    
    // Pairs from base Localizable.strings file
    private var basePairs = [TranslablePair]()
    
    // Pairs from preferred language Localizable.strings file
    private var preferredPairs = [TranslablePair]()
    
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
        let translationPairs = LocalizableFilesLoader(bundle).loadContentFromBaseAndPreferredLanguageFiles(.Localizable)
        let expressionPairs = LocalizableFilesLoader(bundle).loadContentFromBaseAndPreferredLanguageFiles(.Expressions)
        
        basePairs = createTranslablePairsWithTranslationAndExpressionDicts(translationPairs.base, expressions: expressionPairs.base)
        preferredPairs = createTranslablePairsWithTranslationAndExpressionDicts(translationPairs.preferred, expressions: expressionPairs.preferred)
    }
    
    /**
    Enumerate through translation pairs dicts and check if there are some shared patterns that needs to be replaced with custom expressions.
    Next create translable pair with this updated pattern
    */
    private func createTranslablePairsWithTranslationAndExpressionDicts(translations: KVDict, expressions: KVDict) -> [TranslablePair] {
        var pairs = [TranslablePair]()
        
        for (tKey, tValue) in translations {
            var updatedExpression: Expression?
            
            if let existingExpression = Expression.expressionFromString(tKey) {
                if let value = expressions[existingExpression.pattern] {
                    
                    if let updatedExpression = Expression.expressionFromString("{" + value + "}") {
                        
                        if let keyWithoutExpression = Regex.firstMatchInString(tKey, pattern: "^(.*?)(?=\\{)") {
                            pairs.append(TranslablePair(key: keyWithoutExpression + "{" + updatedExpression.pattern + "}", value: tValue))
                            continue
                        }
                    }
                }
            }
            
            pairs.append(TranslablePair(key: tKey, value: tValue))
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
    public class func localizedString(key: String, defaultValue: String? = nil) -> String {
        if sharedInstance() == nil { return (defaultValue != nil) ? defaultValue! : key }
        
        for TranslablePair in sharedInstance().preferredPairs.filter({$0.key == key}) {
            return TranslablePair.value
        }
        
        for TranslablePair in sharedInstance().basePairs.filter({$0.key == key}) {
            return TranslablePair.value
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
        
        let filter = {(pair: TranslablePair) -> Bool  in
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
