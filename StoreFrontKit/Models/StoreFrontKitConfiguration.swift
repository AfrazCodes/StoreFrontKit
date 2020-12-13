//
//  StoreFrontKitConfiguration.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import Foundation

/// Represents store front configuration
public struct StoreFrontKitConfiguration {
    /// Represents products to register with store front
    public let products: Set<StoreFrontProduct>

    public init(products: Set<StoreFrontProduct>) {
        self.products = products
    }
}
