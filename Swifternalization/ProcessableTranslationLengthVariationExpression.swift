import Foundation

/** 
Represents translation which contains expressions with length variations.
*/
struct ProcessableTranslationLengthVariationExpression: TranslationType, Processable {
    /// Key that identifies translation.
    let key: String
    
    /// Array with expressions.
    let expressions: [ProcessableLengthVariationExpression]
    
    /// Creates instances of the class.
    init(key: String, expressions: [ProcessableLengthVariationExpression]) {
        self.key = key
        self.expressions = expressions
    }
}