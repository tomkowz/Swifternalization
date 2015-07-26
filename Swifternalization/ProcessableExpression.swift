import Foundation

/** 
Represents loaded expression that will be processed later.
*/
struct ProcessableExpressionSimple: ExpressionRepresentationType, Processable {
    /// Identifier of expression.
    let identifier: String
    
    /// Pattern of expression.
    let value: String
    
    /// Creates expression.
    init(identifier: String, value: String) {
        self.identifier = identifier
        self.value = value
    }
}
