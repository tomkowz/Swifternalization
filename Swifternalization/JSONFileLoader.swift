import Foundation

/**
Represents json content.
*/
internal typealias JSONDictionary = Dictionary<String, AnyObject>

/**
Simple JSON file loader.
*/
final class JSONFileLoader {
    
    /**
    Loads translations dict for specified language.
    
    :param: countryCode A country code.
    :param: bundle A bundle when file is located.
    :returns: Returns json of file or empty dictionary if cannot load a file.
    */
    class func loadTranslations(countryCode: CountryCode, bundle: NSBundle) -> JSONDictionary {
        return self.load(countryCode, bundle: bundle) ?? [:]
    }
    
    /**
    Loads expressions dict for specified language.
    
    :param: countryCode A country code.
    :param: bundle A bundle when file is located.
    :returns: dictionary with expressions or empty dictionary if cannot load a file.
    */
    class func loadExpressions(countryCode: CountryCode, bundle: NSBundle) -> Dictionary<String, String> {
        return self.load("expressions", bundle: bundle)?[countryCode] as? Dictionary<String, String> ?? [:]
    }
    
    /**
    Loads content of a file with specified name, type and bundle.
    
    :param: fileName A name of a file.
    :param: fileType A type of a file.
    :param: bundle A bundle when file is located.
    :returns: JSON or nil if file cannot be loaded.
    */
    private class func load(fileName: String, bundle: NSBundle) -> JSONDictionary? {
        if let fileURL = bundle.URLForResource(fileName, withExtension: "json") {
            return load(fileURL)
        }
        print("Cannot find file \(fileName).json.")
        return nil
    }
    
    /**
    Loads file for specified URL and try to serialize it.
    
    :params: fileURL url to JSON file.
    :returns: Dictionary with content of JSON file or nil if file cannot be loaded.
    */
    private class func load(fileURL: NSURL) -> JSONDictionary? {
        if let data = NSData(contentsOfURL: fileURL) {
            do {
                if let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? JSONDictionary {
                    return dictionary
                }
                print("Cannot parse JSON. It might be broken.")
                return nil
            } catch {
                print("Cannot parse JSON. It might be broken.")
                return nil
            }
        }
        print("Cannot load content of file.")
        return nil
    }
}
