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
    
    // key-value from base Localizable.strings file
    private var basePairs = [TranslatablePair]()
    
    // key-value airs from preferred language Localizable.strings file
    private var preferredPairs = [TranslatablePair]()
    
    /**
    Swifternalization takes NSBundle when Localizable.strings file is located.
    This method return instance of the class but you don't need it because 
    shared instance is set automatically.
    
    It get Localizable.strings file version based on the first language from 
    the prefferedLocalizations property of NSBundle. If Localizable.strings for
    preferred language isn't exist then Base is used instead.
    */
    public init(bundle: NSBundle) {
        self.bundle = bundle
        
        /// Set it as shared instance
        Swifternalization.setSharedInstance(self)
        
        /// load all the content
        load()
    }
    
    
    // MARK: Private
    private func load() {
        let language = getPreferredLanguage()
        let loader = LocalizableFilesLoader(bundle)
        
        // Get expressions pairs from Expressions.strings files
        let expressionPairsDict = loader.loadContentFromFilesOfType(.Expressions, language: language)
        
        // Get shared expressions for Base and preferred language 
        // including Framwork's shared expressions
        let sharedExpressions = SharedExpressionsConfigurator.configureExpressions(expressionPairsDict, language: language)
        
        
        // Get key-value translatable pairs from Localizable.strings files
        let translatablePairsDicts = loader.loadContentFromFilesOfType(.Localizable, language: language)

        // Create TranslatablePair objects
        basePairs = createTranslablePairs(translatablePairsDicts.base, expressions: sharedExpressions.base)
        preferredPairs = createTranslablePairs(translatablePairsDicts.pref, expressions: sharedExpressions.pref)
    }
    
    private func getPreferredLanguage() -> Language {
        // Get preferred language, the one which is set on user's device
        return bundle.preferredLocalizations.first as! Language
    }
    
    /**
    Enumerate through translatable pairs dict and check if there are some shared 
    expression identifiers that needs to be replaced with full expressions.
    
    Next create translatable pairs with susch updated expressions to make it
    ready to be used by framework.
    */
    private func createTranslablePairs(translatableDict: KVDict, expressions: [SharedExpression]) -> [TranslatablePair] {
        var pairs = [TranslatablePair]()
        
        for (tKey, tValue) in translatableDict {
            // Check if there is expression in tKey
            if let existingExpression = Expression.expressionFromString(tKey),
                let sharedExpression = expressions.filter({$0.key == existingExpression.pattern}).first,
                // Create expression with pattern from Expressions.strings and 
                // it it is correct use it
                let updatedExpression = Expression.expressionFromString("{" + sharedExpression.expression + "}"),
                // Add translable pair with this new updated expression
                let keyWithoutExpression = Regex.firstMatchInString(tKey, pattern: InternalPatterns.KeyWithoutExpression.rawValue) {
                    
                pairs.append(TranslatablePair(key: keyWithoutExpression + "{" + updatedExpression.pattern + "}", value: tValue))
                continue
            }
            
            pairs.append(TranslatablePair(key: tKey, value: tValue))
        }
        
        return pairs
    }
}

/**
Internal Shared Instance support.
*/
extension Swifternalization {
    
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
Simple primitive key-value support
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
Expressions key-value translations support.
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

/**
Int support for expressions key-value translations.
*/
public extension Swifternalization {
    public class func localizedExpressionString(key: String, value: Int, defaultValue: String? = nil) -> String {
        return self.localizedExpressionString(key, value: "\(value)", defaultValue: defaultValue)
    }
}
