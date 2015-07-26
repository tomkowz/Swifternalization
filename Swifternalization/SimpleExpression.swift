//
//  SimpleExpression.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class SimpleExpression: ExpressionRepresentationType {
    /// Identifier of expression.
    let identifier: String

    /// A localized value.
    let value: String

    init(identifier: String, value: String) {
        self.identifier = identifier
        self.value = value
    }
}
