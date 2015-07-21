import Foundation

/**
Class represents translation which contains key and length variations.
*/
struct TranslationLengthVariation: TranslationType {
    /// Key that identifies this translation.
    let key: String
    
    /// list of variations.
    let variations: [LengthVariation]
    
    /// Creates translation object
    init(key: String, variations: [LengthVariation]) {
        self.key = key
        self.variations = variations
    }
}