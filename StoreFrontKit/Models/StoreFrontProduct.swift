//
//  StoreFrontProduct.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import Foundation

/// Represents different types of Store Kit Product
public enum StoreFrontProduct: Hashable {
    /// Represents subscription
    case subscription(productID: String, viewModel: StoreFrontProductViewModel?)
    /// Represents single time purchase item
    case nonConsumable(productID: String, viewModel: StoreFrontProductViewModel?)
    /// Represents item that can be purchased multiple times; Ex: Digital coins in game
    case consumable(productID: String, viewModel: StoreFrontProductViewModel?)

    /// Hasher for set usage
    /// - Parameter hasher: Hasher object to compute item hash value
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    /// Equatability of products
    public static func == (lhs: StoreFrontProduct, rhs: StoreFrontProduct) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    /// StoreKit product identifier
    var identifier: String {
        switch self {
        case .subscription(let productID, _): return productID
        case .consumable(let productID, _): return productID
        case .nonConsumable(let productID, _): return productID
        }
    }

    /// Represents optional product viewModel
    var viewModel: StoreFrontProductViewModel? {
        switch self {
        case .subscription(_, let viewModel): return viewModel
        case .consumable(_, let viewModel): return viewModel
        case .nonConsumable(_, let viewModel): return viewModel
        }
    }
}
