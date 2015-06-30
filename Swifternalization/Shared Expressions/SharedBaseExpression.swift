//
//  BaseExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

/// Contains base expressions that matches every country.
class SharedBaseExpression: SharedExpressionProtocol {
    
    /// Return expressions that matches every country.
    static func allExpressions() -> [SharedExpression] {
        return [
            
            /// Matches value equals 1.
            SharedExpression(key: "one", pattern: "ie:%d=1"),
            
            /// Matches value greater than 1.
            SharedExpression(key: ">one", pattern: "ie:%d>1"),
            
            /// Matches value equals 2.
            SharedExpression(key: "two", pattern: "ie:%d=2"),
            
            /// Matches value other than 1.
            SharedExpression(key: "other", pattern: "exp:(^[^1])|(^\\d{2,})")
        ]
    }
}