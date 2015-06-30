//
//  KeyValue.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/// Represents key from .strings file
internal typealias Key = String

/// Representes value from .strings file
internal typealias Value = String

/// Represent key-value pair of Key and Value from .strings file.
internal typealias KVDict = Dictionary<Key, Value>

/** 
Protocol that defines properties and methods that need to be implemented by
objects that keeps key-value pair things.
*/
protocol KeyValue {
    /// A key.
    var key: Key {get set}
    
    /// A value.
    var value: Value {get set}
    
    /// Initializer.
    init(key: Key, value: Value)
}