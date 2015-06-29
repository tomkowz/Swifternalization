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
    
    // Bundle where files are located
    private let bundle: NSBundle
    
    init(_ bundle: NSBundle) {
        self.bundle = bundle
    }
    
    func loadContentFromFilesOfType(type: StringsFileType, language: Language) -> BasePrefDicts {
        var basePairs = KVDict()
        var preferredPairs = KVDict()
        
        let getURL = URLforFile(type)
        
        // Get file url for preferred language .strings file and load if exist.
        if let localizableStringsFileURL = getURL(language) {
            preferredPairs = parse(localizableStringsFileURL)
        } else {
            println("\(type.rawValue).strings file not found for \"\(language)\" language")
        }
        
        // Get file url for Base .strings file and load if exist.
        if let baseStringsFileURL = getURL(BaseLanguage) {
            basePairs = parse(baseStringsFileURL)
        } else {
            println("\(type.rawValue).strings file not found for Base localization")
        }
        
        return (basePairs, preferredPairs)
    }
    
    // MARK: Private
    private func URLforFile(type: StringsFileType)(_ language: Language) -> NSURL? {
        return bundle.URLForResource(type.rawValue, withExtension: "strings", subdirectory: language + ".lproj")
    }
    
    private func parse(fileURL: NSURL) -> KVDict {
        if let dictionary = NSDictionary(contentsOfURL: fileURL) as? KVDict {
            return dictionary
        } else {
            println("Cannot load Dictionary from content of URL: \(fileURL)")
        }
        
        return KVDict()
    }
}
