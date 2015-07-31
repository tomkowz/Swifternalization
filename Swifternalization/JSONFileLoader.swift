import Foundation

/**
Represents json content.
*/
typealias JSONDictionary = Dictionary<String, AnyObject>

/**
Simple JSON loader.
*/
final class JSONFileLoader {
    
    /**
    Loads translations dict for specified language.
    
    :param: countryCode A country code.
    :param: bundle A bundle when file is located.
    :returns: Returns json of file or nil if cannot load a file.
    */
    class func loadTranslations(countryCode: CountryCode, bundle: NSBundle = NSBundle.mainBundle()) -> JSONDictionary {
        return self.load(countryCode, bundle: bundle) ?? [:]
    }
    
    /**
    Loads expressions dict for specified language.
    
    :param: countryCode A country code.
    :param: bundle A bundle when file is located.
    :returns: dictionary with expressions or nil.
    */
    class func loadExpressions(countryCode: CountryCode, bundle: NSBundle = NSBundle.mainBundle()) -> Dictionary<String, String> {
        return self.load("expressions", bundle: bundle)?[countryCode] as? Dictionary<String, String> ?? [:]
    }
    
    /**
    Loads content of a file with specified name, type and bundle.
    
    :param: fileName A name of a file.
    :param: fileType A type of a file.
    :param: bundle A bundle when file is located.
    :returns: JSON or nil.
    */
    private class func load(fileName: String, bundle: NSBundle = NSBundle.mainBundle()) -> JSONDictionary? {
        if let fileURL = bundle.URLForResource(fileName, withExtension: "json") {
            return load(fileURL)
        }
        println("Cannot find file \(fileName).json.")
        return nil
    }
    
    /**
    Loads file for specified URL and try to serialize it.
    
    :params: fileURL url to JSON file.
    :returns: Dictionary with content of JSON file or nil.
    */
    private class func load(fileURL: NSURL) -> JSONDictionary? {
        if let data = NSData(contentsOfURL: fileURL) {
            var error: NSError?
            if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as? JSONDictionary {
                return dictionary
            }
            print("Cannot parse JSON. It might be broken.")
            return nil
        }
        print("Cannot load content of file.")
        return nil
    }
}
