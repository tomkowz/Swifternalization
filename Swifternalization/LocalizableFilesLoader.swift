//
//  LocalizableFilesLoader.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

enum StringsFileType: String {
    case Localizable = "Localizable"
    case Expressions = "Expressions"
}

class LocalizableFilesLoader {
    private let BaseLanguage: Language = "Base"

    private let bundle: NSBundle
    
    init(_ bundle: NSBundle) {
        self.bundle = bundle
    }
    
    func loadContentFromBaseAndPreferredLanguageFiles(fileType: StringsFileType) -> (base: Dictionary<Key, Value>, preferred: Dictionary<Key, Value>) {
        var basePairs = Dictionary<Key, Value>()
        var preferredPairs = Dictionary<Key, Value>()
        
        // Get file url for localization
        
        if let localizableStringsFileURL = localizableFileURLForLanguage(fileType, language: getPreferredLanguage()) {
            // load content of existing file
            preferredPairs = parse(localizableStringsFileURL)
        }
    
        if let baseStringsFileURL = localizableFileURLForLanguage(fileType, language: BaseLanguage) {
            // load content of existing file
            basePairs = parse(baseStringsFileURL)
        }
        
        return (basePairs, preferredPairs)
    }
    
    private func localizableFileURLForLanguage(fileType: StringsFileType, language: Language) -> NSURL? {
        return bundle.URLForResource(fileType.rawValue, withExtension: "strings", subdirectory: language + ".lproj")
    }
    
    private func getPreferredLanguage() -> Language {
        // Get preferred language, the one which is set on user's device
        return bundle.preferredLocalizations.first as! Language
    }
    
    private func parse(fileURL: NSURL) -> Dictionary<Key, Value> {
        if let dictionary = NSDictionary(contentsOfURL: fileURL) as? Dictionary<Key, Value> {
            return dictionary
        }
        
        return Dictionary<Key, Value>()
    }
}
