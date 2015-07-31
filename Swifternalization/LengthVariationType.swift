import Foundation

/** 
Represents length variation.
*/
protocol LengthVariationType {
    /// Length of a screen.
    var length: Int {get}
    
    /// Localized value.
    var value: String {get}
}
