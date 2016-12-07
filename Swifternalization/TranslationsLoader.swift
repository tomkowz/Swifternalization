import Foundation

/**
Class that gets dictionary of translations and turn it into `LoadedTranslation`s.
*/
final class TranslationsLoader {
    
    /**
    Converts dictionary into array of `LoadedTranslation`s.
    
    :params: dictionary A dictionary with content of file which contains 
        translations.
    :returns: Array of `LoadedTranslation` objects from specified file.
    */
    class func loadTranslations(_ json: Dictionary<String, AnyObject>) -> [LoadedTranslation] {
        var loadedTranslations = [LoadedTranslation]()
        for (key, value) in json {
            if value is String {
                loadedTranslations.append(LoadedTranslation(type: .simple, key: key, content: [key: value]))
            } else {
                let dictionary = value as! JSONDictionary
                if let type = detectElementType(dictionary) {
                    loadedTranslations.append(LoadedTranslation(type: type, key: key, content: dictionary))
                } else {
                    print("Translation type is not supported for: \(dictionary)")
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
    private class func detectElementType(_ element: JSONDictionary) -> LoadedTranslationType? {
        // Method counts dicts and strings occurences and return proper type.
        var dicts = 0
        var strings = 0
        
        // Count every string or dict occurence.
        for (_, value) in element {
            if value is String {
                strings += 1
            } else if value is Dictionary<String, AnyObject> {
                dicts += 1
            }
        }
        
        /*
        If there is only string then check if the keys are length variations or
        contain some expressions. IF there is some dict and some strings (or no
        strings) then mark it as expressions with length variations.
        */
        if strings > 0 && dicts == 0 {
            let key = element.keys.first!
            let toIndex = key.characters.index(key.startIndex, offsetBy: 1)
            return key.substring(to: toIndex) == "@" ? .withLengthVariations : .withExpressions
        } else if strings >= 0 && dicts > 0 {
            return .withExpressionsAndLengthVariations
        }
        
        // Not supported type should be nil.
        return nil
    }
}
