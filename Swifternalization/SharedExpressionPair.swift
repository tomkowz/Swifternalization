//
//  SharedExpressionPair.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

struct SharedExpressionPair: KeyValue {
    var key: Key
    var value: Value
    
    private var expression: Expression? = nil
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}
