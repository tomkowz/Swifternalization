//
//  BaseExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

class SharedBaseExpression: SharedExpressionProtocol {
    static func allExpressions() -> [SharedExpression] {
        return [
            // 1
            SharedExpression(k: "one", e: "ie:%d=1"),
            
            // 2, 3, 4...
            SharedExpression(k: ">one", e: "ie:%d>1"),
            
            // 2
            SharedExpression(k: "two", e: "ie:%d=2"),
            
            // 0, 2 ,3...
            SharedExpression(k: "other", e: "exp:(^[^1])|(^\\d{2,})")
        ]
    }
}