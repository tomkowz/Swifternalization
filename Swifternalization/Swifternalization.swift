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

public class Swifternalization {
    static let sharedInstance = Swifternalization()
    
    private var translations = [Translation]()
    
    // MARK: Public Methods
    
    public class func configure(bundle: NSBundle = NSBundle.mainBundle()) {
        sharedInstance.load(bundle: bundle)
    }
    
    public class func localizedString(key: String, stringValue: String, fittingWidth: Int? = nil, defaultValue: String? = nil, comment: String? = nil) -> String {
        let filteredTranslations = sharedInstance.translations.filter({$0.key == key})
        if let translation = filteredTranslations.first {
            if let matchingExpression = translation.validate(stringValue ?? key, length: fittingWidth) {
                if fittingWidth == nil {
                    return matchingExpression.localizedValue
                } else if  matchingExpression.lengthVariations.count == 0 {
                    return matchingExpression.localizedValue
                } else if matchingExpression.lengthVariations.count > 0 {
                    /// GET PROPER VARIANT
                }
            }
        }
        
        return (defaultValue != nil) ? defaultValue! : key
    }
    
    public class func localizedString(key: String, intValue: Int, fittingWidth: Int? = nil, defaultValue: String? = nil, comment: String? = nil) -> String {
        return localizedString(key, stringValue: "\(intValue)", fittingWidth: fittingWidth, defaultValue: defaultValue, comment: comment)
    }
    
    public class func localizedString(key: String, fittingWidth: Int? = nil, defaultValue: String? = nil, comment: String? = nil) -> String {
        return localizedString(key, stringValue: key, fittingWidth: fittingWidth, defaultValue: defaultValue, comment: comment)
    }
    
    // MARK: Private Methods
    
    private func load(bundle: NSBundle = NSBundle.mainBundle()) {
        let base = "base"
        let language = getPreferredLanguage(bundle)
        
        let baseExpressions = SharedExpressionsLoader.loadExpressions(JSONFileLoader.loadExpressions(base, bundle: bundle) ?? [:])
        let languageExpressions = SharedExpressionsLoader.loadExpressions(JSONFileLoader.loadExpressions(language, bundle: bundle) ?? [:])
        let expressions = SharedExpressionsProcessor.processSharedExpression(language, preferedLanguageExpressions: languageExpressions, baseLanguageExpressions: baseExpressions)
        
        let baseTranslations = TranslationsLoader.loadTranslations(JSONFileLoader.loadTranslations(base, bundle: bundle) ?? [:])
        let languageTranslations = TranslationsLoader.loadTranslations(JSONFileLoader.loadTranslations(language, bundle: bundle) ?? [:])
        
        translations = LoadedTranslationsProcessor.processTranslations(baseTranslations, preferedLanguageTranslations: languageTranslations, sharedExpressions: expressions)
    }
    
    /// Gets preferred language of user's device
    private func getPreferredLanguage(bundle: NSBundle) -> CountryCode {
        // Get preferred language, the one which is set on user's device
        return bundle.preferredLocalizations.first as! CountryCode
    }
}
