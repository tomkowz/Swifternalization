import Foundation

/** 
Represents loaded expression that will be processed later.
*/
struct ProcessableExpression: ExpressionRepresentationType, ExpressionPatternType, Processable {
    /// Identifier of expression.
    let identifier: String
    
    /// Pattern of expression.
    let pattern: String
    
    /// Creates expression.
    init(identifier: String, pattern: String) {
        self.identifier = identifier
        self.pattern = pattern
    }
}
