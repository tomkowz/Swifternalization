import Foundation

/** 
Represents translation which contains expressions with length variations.
*/
public struct ProcessableTranslationLengthVariationExpression: TranslationType, Processable {
    /// Key that identifies translation.
    public let key: String
    
    /// Array with expressions.
    let expressions: [ProcessableLengthVariationExpression]
    
    /// Creates instances of the class.
    public init(key: String, expressions: [ProcessableLengthVariationExpression]) {
        self.key = key
        self.expressions = expressions
    }
}