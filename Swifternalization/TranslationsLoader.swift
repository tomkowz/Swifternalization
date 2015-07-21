import Foundation

/** 
Represents translations loader.
Class is looking for json file named as country code.
It parse such file.
*/
final class TranslationsLoader: JSONFileLoader {
    
    typealias DictWithStrings = Dictionary<String, String>
    typealias DictWithDicts = Dictionary<String, DictWithStrings>
    
    enum ElementType {
        case NotSupported
        case TranslationWithLengthVariations
        case TranslationWithLoadedExpressions
        case TranslationWithLengthVariationsAndLoadedExpressions
    }
    
    /**
    Method loads a file and parses it.
    
    :params: countryCode A country code.
    
    :return: translations parsed from the file.
    */
    class func loadTranslations(countryCode: CountryCode) -> [TranslationType] {
        var loadedTranslations = [TranslationType]()
        let json = self.load(countryCode, fileType: "json", bundle: NSBundle.mainBundle())
        if json == nil { return [TranslationType]() }
        
        for (translationKey, value) in json! {
            if let translationValue = value as? String {
                loadedTranslations.append(TranslationSimple(key: translationKey, value: translationValue))
            } else {
                let dictionary = value as! JSONDictionary
                switch detectElementType(dictionary) {
                case .TranslationWithLengthVariations:
                    let variations = parseLengthVariations(dictionary as! DictWithStrings)
                    loadedTranslations.append(TranslationLengthVariation(key: translationKey, variations: variations))

                case .TranslationWithLoadedExpressions:
                    let expressions = parseExpressions(dictionary as! DictWithStrings)
                    loadedTranslations.append(ProcessableTranslation(key: translationKey, loadedExpressions: expressions))

                case .TranslationWithLengthVariationsAndLoadedExpressions:
                    var expressions = [ProcessableLengthVariationExpression]()
                    for (expressionIdentifier, lengthVariationsDict) in dictionary as! DictWithDicts {
                        let variations = parseLengthVariations(lengthVariationsDict)
                        expressions.append(ProcessableLengthVariationExpression(identifier: expressionIdentifier, variations: variations))
                    }
                    loadedTranslations.append(ProcessableTranslationLengthVariationExpression(key: translationKey, expressions: expressions))
                    
                case .NotSupported:
                    // Do nothing
                    continue
                }
            }
        }
        
        return loadedTranslations
    }
    
    private class func parseLengthVariations(dict: DictWithStrings) -> [LengthVariation] {
        var variations = [LengthVariation]()
        for (key, translationValue) in dict {
            let numberValue = parseNumberFromLengthVariation(key)
            variations.append(LengthVariation(length: numberValue, value: translationValue))
        }
        return variations
    }
    
    private class func parseExpressions(dict: DictWithStrings) -> [ProcessableExpression] {
        var expressions = [ProcessableExpression]()
        for (expressionKey, translationValue) in dict {
            expressions.append(ProcessableExpression(identifier: expressionKey, pattern: translationValue))
        }
        return expressions
    }
    
    private class func detectElementType(element: JSONDictionary) -> ElementType {

        if element is DictWithStrings {
            if let key = element.keys.first {
                let toIndex = advance(key.startIndex, 1)
                let firstCharacter = key.substringToIndex(toIndex)
                if firstCharacter == "@" {
                    return .TranslationWithLengthVariations
                } else {
                    return .TranslationWithLoadedExpressions
                }
            }
        } else if element is DictWithDicts {
            return .TranslationWithLengthVariationsAndLoadedExpressions
        }
        
        return .NotSupported
    }
    
    private class func parseNumberFromLengthVariation(string: String) -> Int {
        return (Regex.matchInString(string, pattern: "@(\\d+)", capturingGroupIdx: 1)! as NSString).integerValue
    }
}
