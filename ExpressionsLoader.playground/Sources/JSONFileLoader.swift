import Foundation

/**
Simple JSON loader.
*/
public class JSONFileLoader {
    public typealias JSONDictionary = Dictionary<String, AnyObject>
    
    /**
    Load content of file with specified name, type and bundle.
    
    :param: fileName A name of a file.
    :param: fileType A type of a file.
    :param: bundle A bundle when file is located.
    
    :return: JSON or nil.
    */
    public final class func load(fileName: String, fileType: String, bundle: NSBundle = NSBundle.mainBundle()) -> JSONDictionary? {
        if let fileURL = bundle.URLForResource(fileName, withExtension: fileType) {
            return load(fileURL)
        }
        println("Cannot find file \(fileName).\(fileType).")
        return nil
    }
    
    /**
    Loads file for specified URL and try to serialize it.
    
    :params: fileURL url to JSON file.
    
    :return: Dictionary with content of JSON file or nil.
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
