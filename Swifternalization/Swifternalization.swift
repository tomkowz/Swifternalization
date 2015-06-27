//
//  Swifternalization.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

public typealias I18N = Swifternalization

typealias Key = String
typealias Value = String

public class Swifternalization {
    typealias Language = String
    private let BaseLanguage: Language = "Base"

    private let bundle: NSBundle
    private var pairs = [Pair]()
    
    public init(bundle: NSBundle) {
        self.bundle = bundle
        Swifternalization.setSharedInstance(self)
        load()
    }
    
    
    // MARK: Private
    private func load() {
        // Get file url for localization
        var fileURL = localizableFileURLForLanguage(preferredLanguage())
        if fileURL == nil {
            fileURL = localizableFileURLForLanguage(BaseLanguage)
        }
        
        if fileURL == nil { return }
        
        // load content of existing file
        if let dictionary = NSDictionary(contentsOfURL: fileURL!) as? Dictionary<Key, Value> {
            parse(dictionary)
        }
    }
    
    private func parse(dictionary: Dictionary<Key, Value>) {
        for (k, v) in dictionary {
            pairs.append(Pair(key: k, value: v))
        }
    }
    
    private func preferredLanguage() -> Language {
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

public extension Swifternalization {
    
    /// Returns localized string if found, otherwise the passed one
    public class func localizedString(key: String) -> String {
        if sharedInstance() == nil { return key }
        var result: String? = localizedValue(key)
        return result != nil ? result! : key
    }
    
    public class func localizedString(key: String, value: String) -> String {
        if sharedInstance() == nil { return key }
        var result: String? = localizedValue(key)
        return result != nil ? result! : value
    }
    
    private class func localizedValue(key: String) -> String? {
        for pair in sharedInstance().pairs {
            if pair.key == key { return pair.value }
        }

        return nil
    }
}
