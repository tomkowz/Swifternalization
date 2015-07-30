import Foundation

/**
Simple JSON loader.
*/
class JSONFileLoader {
    typealias JSONDictionary = Dictionary<String, AnyObject>
    
    /**
    Loads content of a file with specified name, type and bundle.
    
    :param: fileName A name of a file.
    :param: fileType A type of a file.
    :param: bundle A bundle when file is located.
    :returns: JSON or nil.
    */
    final class func load(fileName: String, bundle: NSBundle = NSBundle.mainBundle()) -> JSONDictionary? {
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
            } else {
                print("Cannot parse JSON. It might be broken.")
            }
        }
        print("Cannot load content of file.")
        return nil
    }
}
