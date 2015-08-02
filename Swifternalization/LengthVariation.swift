import Foundation

/**
Length variation representation. It contains a width property which specifies 
up to which width of a screen the text in `value` property should be presented.
*/
struct LengthVariation {
    /** 
    Max width of a screen on which the `value` should be presented.
    */
    let width: Int
    
    /** 
    String with localized content in some language.
    */
    let value: String
}
