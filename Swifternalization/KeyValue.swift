//
//  KeyValue.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

typealias Key = String
typealias Value = String
typealias KVDict = Dictionary<Key, Value>

protocol KeyValue {
    var key: Key {get set}
    var value: Value {get set}
    
    init(key: Key, value: Value)
}