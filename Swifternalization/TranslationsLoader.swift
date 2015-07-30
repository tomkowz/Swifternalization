import Foundation

/**
Class that loads translations from a file.
*/
final class TranslationsLoader: JSONFileLoader {
    
    /**
    Loads content from file with name equal to passed country code in a bundle.
    
    :params: countryCode A country code.
    :params: bundle A bundle when file is placed.
    :returns: `LoadedTranslation` objects from specified file.
    */
    class func loadTranslations(countryCode: CountryCode, bundle: NSBundle = NSBundle.mainBundle()) -> [LoadedTranslation] {
        var loadedTranslations = [LoadedTranslation]()
        if let json = self.load(countryCode, bundle: bundle) {
            for (key, value) in json {
                if value is String {
                    loadedTranslations.append(LoadedTranslation(type: .Simple, content: [key: value]))
                } else {
                    let dictionary = value as! JSONDictionary
                    if let type = detectElementType(dictionary) {
                        loadedTranslations.append(LoadedTranslation(type: type, content: dictionary))
                    } else {
                        println("Translation type is not supported for: \(dictionary)")
                    }
                }
            }
        }
        
        return loadedTranslations
    }
    
    /**
    Analyzes passed dictionary and checks its content to match it to some translation type.
    
    :params: element A dictionary that will be analyzed.
    :returns: translation type of a dictionary.
    */
    private class func detectElementType(element: JSONDictionary) -> LoadedTranslationType? {
        typealias DictWithStrings = Dictionary<String, String>
        typealias DictWithDicts = Dictionary<String, DictWithStrings>
        
        if element is DictWithStrings, let key = element.keys.first {
            let toIndex = advance(key.startIndex, 1)
            return key.substringToIndex(toIndex) == "@" ? .WithLengthVariations : .WithExpressions
        } else if element is DictWithDicts {
            return .WithExpressionsAndLengthVariations
        }
        
        return nil
    }
}
