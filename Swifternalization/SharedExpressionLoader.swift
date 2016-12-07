import Foundation

/**
Used to load content from `expressions.json` file for specified language.
*/
final class SharedExpressionsLoader {
    
    /**
    Loads expressions for specified language.
    
    :param: countryCode A country code
    :returns: array of loaded expressions.
    */
    class func loadExpressions(_ json: Dictionary<String, String>) -> [SharedExpression] {
        var expressions = [SharedExpression]()
        for (identifier, pattern) in json {
            expressions.append(SharedExpression(identifier: identifier, pattern: pattern))
        }
        return expressions
    }
}
