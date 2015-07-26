import Foundation

/**
Used to load content from `expressions.json` file for specified language.
*/
final class SharedExpressionsLoader: JSONFileLoader {
    
    /**
    Loads expressions for specified language.
    
    :param: countryCode A country code
    
    :returns: array of loaded expressions.
    */
    class func loadExpressions(countryCode: CountryCode, bundle: NSBundle) -> [SharedExpression] {
        var expressions = [SharedExpression]()
        if let json = self.load("expressions", bundle: bundle),
            let expressionsDict = json[countryCode] as? Dictionary<String, String> {
                for (identifier, pattern) in expressionsDict {
                    expressions.append(SharedExpression(identifier: identifier, pattern: pattern))
                }
        } else {
            println("expressions.json file structure is incorrect.")
        }
        return expressions
    }
}
