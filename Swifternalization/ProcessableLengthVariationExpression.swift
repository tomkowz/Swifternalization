import Foundation

/**
Represents processable expression with length variations.
*/
struct ProcessableLengthVariationExpression: ExpressionRepresentationType, Processable {
    /// Identifier of expression.
    var identifier: String
    
    /// Array of length variations
    var variations: [LengthVariation]
    
    /// Creates instance of the class.
    init(identifier: String, variations: [LengthVariation]) {
        self.identifier = identifier
        self.variations = variations
    }
}
