//
//  Swifternalization.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/// Handy typealias that can be used instead of long `Swifternalization`
public typealias I18n = Swifternalization

/** 
Defines language selected on the user's device e.g. en, pl, ru.
Language can be also Base. It used used for finding right Localizable.strings 
and Expression.strings and to load built-in shared expressions.
*/
internal typealias Language = String

/**
This is the main class of Swifternalization library. It exposes methods
that can be used to get localized keys with or without expressions from 
Localizable.strings files.

It also uses Expressions.strings files to manage shared expressions that
can have theirs identifiers placed in many versions of the Localizable.strings
file.

Internal classes of the Swifternalization contains logic that is responsible 
for detecting which value should be used for the given key and value.

It is able to work with genstrings command-line tool like NSLocalizedString() 
macro does.

It looks for content in the NSBundle you can provide and try to find:

- Localizable.strings (Base),
- Localizable.strings of preferred language, e.g. Localizable.strings (en)
- Expressions.strings (Base), 
- Expressions.strings of preferred language, e.g. Expressions.strings (en)
*/
public class Swifternalization {
    
    /// Struct to keep shared instance of `Swifternalization`
    private struct Static {
        /// Instance of `Swifternalization` that might be nil if not set.
        static var instance: Swifternalization? = nil
    }
        
    /// Bundle when Localizable and Expressions .strings files are located.
    private let bundle: NSBundle
    
    /// key-value from base Localizable.strings file
    private var basePairs = [TranslatablePair]()
    
    /// key-value airs from preferred language Localizable.strings file
    private var preferredPairs = [TranslatablePair]()
    
    // MARK: Public methods
    /**
    Swifternalization takes NSBundle when Localizable.strings file is located.
    This method return instance of the class but you don't need it because 
    shared instance is set automatically.
    
    It get Localizable.strings file version based on the first language from 
    the prefferedLocalizations property of NSBundle. If Localizable.strings for
    preferred language isn't exist then Base is used instead.
    
    :param: bundle bundle when .strings files are located.
    */
    public init(bundle: NSBundle) {
        self.bundle = bundle
        
        /// Set it as shared instance
        Swifternalization.setSharedInstance(self)
        
        /// load all the content
        load()
    }
    
    /**
    Returns localized string for simple key that does not contain any expression.
    
        I18n.localizedString("car")
        I18n.localizedString("car", defaultValue: "Audi")
        I18n.localizedString("car", defaultValue: "Audi", comment: "Comment")
        I18n.localizedString("car", comment: "Comment")
    
    :param: key key placed in Localizable.strings file.
    :param: defaultValue default value that will be returned when there is no 
            translation for passed key. Default is nil.
    :param: comment comment used by genstrings tool to generate description of 
            a key. Default is nil.
    
    :returns: Returns translation for passed key if found. If not found and 
            defaultValue is not nil it return defaultValue, otherwise
            returns key.
    */
    public class func localizedString(key: String, defaultValue: String? = nil, comment: String? = nil) -> String {
        if sharedInstance() == nil { return (defaultValue != nil) ? defaultValue! : key }
        
        for TranslatablePair in sharedInstance().preferredPairs.filter({$0.key == key}) {
            return TranslatablePair.value
        }
        
        for TranslatablePair in sharedInstance().basePairs.filter({$0.key == key}) {
            return TranslatablePair.value
        }
        
        return (defaultValue != nil) ? defaultValue! : key
    }
    
    /**
    Returns localized string for key which contains expression.
    
        I18n.localizedExpressionString("cars", value: "10")
        I18n.localizedExpressionString("cars", value: "10", defaultValue: "Few cars")
        I18n.localizedExpressionString("cars", value: "10", defaultValue: "10", comment: "This is a comment")
        I18n.localizedExpressionString("cars", value: "10", comment: "This is a comment")
    
    :param: key key placed in Localizable.strings file.
    :param: value value used when validating expressions.
    :param: defaultValue default value that will be returned when there is no 
            translation for passed key. Default is nil.
    :param: comment comment used by genstrings tool to generate description 
            of a key. Default is nil.
    
    :returns: Returns translation for passed key if found. If not found and 
            defaultValue is not nil it return defaultValue, otherwise returns key.
    */
    public class func localizedExpressionString(key: String, value: String, defaultValue: String? = nil, comment: String? = nil) -> String {
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

    /**
    This method is just extension to method
    `localizedExpressionString(_:value:defaultValue:comment:)` that takes 
    `String` as a `value` parameter.
    */
    public class func localizedExpressionString(key: String, value: Int, defaultValue: String? = nil, comment: String? = nil) -> String {
        return self.localizedExpressionString(key, value: "\(value)", defaultValue: defaultValue, comment: comment)
    }
    
    // MARK: Private methods
    
    /// Method that set shared instance of Swifternalization
    private class func setSharedInstance(instance: Swifternalization) {
        Static.instance = instance
    }
    
    /// Method that returns shared instance of Swifternalization
    /// :returns: `Swifternalization` shared instance
    private class func sharedInstance() -> Swifternalization! {
        return Static.instance
    }
    
    /**
    Method responsible for loading content into Swifternaliztion library. 
    It takes preferred language of user's device, and tries to find 
    Localizable.strings (Preferred Language) and Localizable.strings (Base) 
    to get keys and values of words to translate.

    It also tries to find and load Expressions.strings (Preferred Language)
    and Expressions.strings (Base) files when shared expressions might be 
    and tries to combine them together with built-in shared expression,
    and at the end enumeate through key-value pairs for translation and 
    changes keys that have only expression shortcuts to full expressions.
    */
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
    
    /// Gets preferred language of user's device
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
            if let expressionPattern = Expression.parseExpressionPattern(tKey),
                let sharedExpression = expressions.filter({$0.key == expressionPattern}).first,
                // Create expression with pattern from Expressions.strings and
                // it it is correct use it.
                let updatedExpression = Expression.expressionFromString("{" + sharedExpression.pattern + "}"),
                // Add translable pair with this new updated expression
                let keyWithoutExpression = Regex.firstMatchInString(tKey, pattern: InternalPattern.KeyWithoutExpression.rawValue) {
                    
                pairs.append(TranslatablePair(key: keyWithoutExpression + "{" + updatedExpression.pattern + "}", value: tValue))
                continue
            }
            
            pairs.append(TranslatablePair(key: tKey, value: tValue))
        }
        
        return pairs
    }
}

