//
//  BaseExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

/** 
Contains base expressions that matches every country.
*/
class SharedBaseExpression: SharedExpressionProtocol {
    
    /** 
    Return expressions that matches every country.
    */
    static func allExpressions() -> [SharedExpression] {
        return [
            
            /** 
            Matches value equals 1.
            */
            SharedExpression(identifier: "one", pattern: "ie:x=1"),
            
            /** 
            Matches value greater than 1.
            */
            SharedExpression(identifier: ">one", pattern: "ie:x>1"),
            
            /** 
            Matches value equals 2.
            */
            SharedExpression(identifier: "two", pattern: "ie:x=2"),
            
            /** 
            Matches value other than 1.
            */
            SharedExpression(identifier: "other", pattern: "exp:(^[^1])|(^\\d{2,})")
        ]
    }
}