//
//  LocalizableFilesLoader.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

typealias BasePrefDicts = (base: KVDict, pref: KVDict)

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
    
    func loadContentFromBaseAndPreferredLanguageFiles(fileType: StringsFileType, language: Language) -> BasePrefDicts {
        var basePairs = KVDict()
        var preferredPairs = KVDict()
        
        // Get file url for localization
        if let localizableStringsFileURL = localizableFileURLForLanguage(fileType, language: language) {
            // load content of existing file
            preferredPairs = parse(localizableStringsFileURL)
        }
    
        if let baseStringsFileURL = localizableFileURLForLanguage(fileType, language: BaseLanguage) {
            // load content of existing file
            basePairs = parse(baseStringsFileURL)
        }
        
        return (basePairs, preferredPairs)
    }
    
    
    // MARK: Private
    private func localizableFileURLForLanguage(fileType: StringsFileType, language: Language) -> NSURL? {
        return bundle.URLForResource(fileType.rawValue, withExtension: "strings", subdirectory: language + ".lproj")
    }
    
    private func parse(fileURL: NSURL) -> KVDict {
        if let dictionary = NSDictionary(contentsOfURL: fileURL) as? KVDict {
            return dictionary
        }
        return KVDict()
    }
}
