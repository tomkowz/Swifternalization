import Foundation

/** 
Represents simple key-value translation.
*/
struct TranslationSimple: TranslationType {
    /// Key that identifies translation.
    let key: String
    
    /// Localized string.
    let value: String
    
    /// Creates instance of the class.
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
