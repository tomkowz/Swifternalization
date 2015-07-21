import Foundation

/**
Struct that represents length variation.
*/
struct LengthVariation: LengthVariationType {
    /// Length - width of a screen.
    let length: Int
    
    /// localized string.
    let value: String
    
    /// Create length variation object.
    init(length: Int, value: String) {
        self.length = length
        self.value = value
    }
}