import Foundation

/** 
Represents translation which contains expressions that are not processed yet.
*/
public struct ProcessableTranslation: TranslationType, Processable {
    /// Key that identifies translation.
    public let key: String
    
    /// Array with loaded expressions.
    let loadedExpressions: [ProcessableExpression]
    
    /// Creates instances of the class.
    public init(key: String, loadedExpressions: [ProcessableExpression]) {
        self.key = key
        self.loadedExpressions = loadedExpressions
    }
}
