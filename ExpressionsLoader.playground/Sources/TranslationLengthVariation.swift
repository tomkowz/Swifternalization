import Foundation

/**
Class represents translation which contains key and length variations.
*/
public struct TranslationLengthVariation: TranslationType {
    /// Key that identifies this translation.
    public let key: String
    
    /// list of variations.
    let variations: [LengthVariation]
    
    /// Creates translation object
    public init(key: String, variations: [LengthVariation]) {
        self.key = key
        self.variations = variations
    }
}