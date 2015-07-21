import Foundation

/** 
Represents simple key-value translation.
*/
public struct TranslationSimple: TranslationType {
    /// Key that identifies translation.
    public let key: String
    
    /// Localized string.
    public let value: String
    
    /// Creates instance of the class.
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
