//
//  LocalizableFilesLoader.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation


/**
Type that contains two dictionaries.

base - for Base localization

pref - for preferred language localization

It contains `KVDict` instanes so every one has key and value.
*/
internal typealias BasePrefDicts = (base: KVDict, pref: KVDict)

/// Enum that represents file types used by `LocalizableFilesLoader`.
enum StringsFileType: String {
    /// Localizable.strings file.
    case Localizable = "Localizable"
    /// Expressions.strings file.
    case Expressions = "Expressions"
}

/**
Class responsible for loading content from specified file type.
*/
class LocalizableFilesLoader {
    
    /// Defines Base language - which is equal "Base".
    private let BaseLanguage: Language = "Base"
    
    /// Bundle where files are located
    private let bundle: NSBundle
    
    /**
    Creates `LocalizableFilesLoader` instance.
    
    :param: bundle A bundle where .strings files are located.
    */
    init(_ bundle: NSBundle) {
        self.bundle = bundle
    }
    
    /**
    Loads content from files of specified `type` and `language`.
    Converts them to `BasePrefDicts` instance.
    
    :param: type A type of files that will be loaded.
    :param: language A preferred language - it will be used to find proper 
            file for specified file type.
    
    :returns: Returns content of files converted into key-value pairs.
    */
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
    
    /**
    Returns URL for file with specified type.
    
    :param: type A type of file.
    :param: language A language of file. (localization).
    :returns: `NSURL` to file or nil when file cannot be found.
    */
    private func URLforFile(type: StringsFileType)(_ language: Language) -> NSURL? {
        return bundle.URLForResource(type.rawValue, withExtension: "strings", subdirectory: language + ".lproj")
    }
    
    /**
    Parses files and return key-value pairs.
    
    :param: fileURL URL to file.
    :returns: key-value pairs from .strings files.
    */
    private func parse(fileURL: NSURL) -> KVDict {
        if let dictionary = NSDictionary(contentsOfURL: fileURL) as? KVDict {
            return dictionary
        } else {
            println("Cannot load Dictionary from content of URL: \(fileURL)")
        }
        
        return KVDict()
    }
}
