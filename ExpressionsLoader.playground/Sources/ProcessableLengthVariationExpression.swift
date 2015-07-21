import Foundation

/**
Represents processable expression with length variations.
*/
public struct ProcessableLengthVariationExpression: ExpressionRepresentationType, Processable {
    /// Identifier of expression.
    public var identifier: String
    
    /// Array of length variations
    var variations: [LengthVariation]
    
    /// Creates instance of the class.
    public init(identifier: String, variations: [LengthVariation]) {
        self.identifier = identifier
        self.variations = variations
    }
}
