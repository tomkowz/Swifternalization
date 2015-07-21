import Foundation

/** 
Represents loaded expression that will be processed later.
*/
public struct ProcessableExpression: ExpressionRepresentationType, ExpressionPatternType, Processable {
    /// Identifier of expression.
    public let identifier: String
    
    /// Pattern of expression.
    public let pattern: String
    
    /// Creates expression.
    public init(identifier: String, pattern: String) {
        self.identifier = identifier
        self.pattern = pattern
    }
}
