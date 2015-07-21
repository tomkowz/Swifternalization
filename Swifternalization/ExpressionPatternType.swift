import Foundation

/**
Represents objects that have expression pattern.
Example an expression that contains just pattern, without things like  length 
variations.
*/
protocol ExpressionPatternType {
    /// A pattern.
    var pattern: String {get}
}