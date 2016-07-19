//
//  RandomNumberExtensions.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 15/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/// http://stackoverflow.com/a/28075271/1046965
func arc4random <T: IntegerLiteralConvertible> (_ type: T.Type) -> T {
    var r: T = 0
    arc4random_buf(&r, Int(sizeof(T.self)))
    return r
}

extension Float {
    static func random(lower: Float, upper: Float) -> Float {
        let r = Float(arc4random(UInt32.self)) / Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }
    
    static func randomNumbers(lower: Float, upper: Float, count: Int) -> [Float] {
        var nums = [Float]()
        for _ in 0..<count {
            nums.append(random(lower: lower, upper: upper))
        }
        return nums
    }
    
    static func randomNumbersStrings(lower: Float, upper: Float, count: Int) -> [String] {
        var numStr = [String]()
        for i in randomNumbers(lower: lower, upper: upper, count: count) {
            numStr.append(String(format: "%f", i))
        }
        return numStr
    }
}
