import Foundation

/**
Struct that represents length variation.
*/
public struct LengthVariation: LengthVariationType {
    /// Length - width of a screen.
    public let length: Int
    
    /// localized string.
    public let value: String
    
    /// Create length variation object.
    public init(length: Int, value: String) {
        self.length = length
        self.value = value
    }
}