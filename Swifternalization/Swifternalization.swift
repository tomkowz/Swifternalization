//
//  Swifternalization.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

public typealias I18N = Swifternalization

public class Swifternalization {
    typealias Language = String
    
    private let BaseLanguage: Language = "Base"

    private let bundle: NSBundle
    private var preferredLanguage: Language!
    
    // Pairs from base Localizable.strings file
    private var basePairs = [Pair]()
    
    // Pairs from preferred language Localizable.strings file
    private var preferredPairs = [Pair]()
    
    /** 
    Initialize with bundle when Localizable.strings file is located.
    This method return instance of the class but you don't need it.
    Shared instance is automatically set so you can start using class method.
    
    It get the Localizable.strings file version based on language set on the device using 'preferredLocations' property of NSBUndle.
    If version for specific language isn't found it tries with Base version.
    */
    public init(bundle: NSBundle) {
        self.bundle = bundle
        self.preferredLanguage = getPreferredLanguage()
        Swifternalization.setSharedInstance(self)
        load()
    }
    
    
    // MARK: Private
    private func load() {
        // Get file url for localization
        if let localizableStringsFileURL = localizableFileURLForLanguage(self.preferredLanguage) {
            // load content of existing file
            preferredPairs = parse(localizableStringsFileURL)
        }
        
        if let baseStringsFileURL = localizableFileURLForLanguage(BaseLanguage) {
            // load content of existing file
            basePairs = parse(baseStringsFileURL)
        }
    }
    
    private func parse(fileURL: NSURL) -> [Pair] {
        var pairs = [Pair]()
        if let dictionary = NSDictionary(contentsOfURL: fileURL) as? Dictionary<Key, Value> {
            pairs += parse(dictionary)
        }
        return pairs
    }
    
    private func parse(dictionary: Dictionary<Key, Value>) -> [Pair] {
        var pairs = [Pair]()
        for (k, v) in dictionary {
            pairs.append(Pair(key: k, value: v))
        }
        return pairs
    }
    
    private func getPreferredLanguage() -> Language {
        // Get preferred language, the one which is set on user's device
        return bundle.preferredLocalizations.first as! Language
    }
    
    private func localizableFileURLForLanguage(language: Language) -> NSURL? {
        return bundle.URLForResource("Localizable", withExtension: "strings", subdirectory: language + ".lproj")
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
        
        for pair in sharedInstance().preferredPairs.filter({$0.key == key}) {
            return pair.value
        }
        
        for pair in sharedInstance().basePairs.filter({$0.key == key}) {
            return pair.value
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
        
        let filter = {(pair: Pair) -> Bool  in
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
