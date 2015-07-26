import Foundation

/** 
Represents translation which contains expressions that are not processed yet.
*/
struct ProcessableTranslationExpression: TranslationType, Processable {
    /// Key that identifies translation.
    let key: String
    
    /// Array with loaded expressions.
    let loadedExpressions: [ProcessableExpressionSimple]
    
    /// Creates instances of the class.
    init(key: String, loadedExpressions: [ProcessableExpressionSimple]) {
        self.key = key
        self.loadedExpressions = loadedExpressions
    }
}
