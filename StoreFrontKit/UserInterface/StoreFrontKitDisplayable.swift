//
//  StoreFrontKitDisplayable.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import Foundation

// TODO: Update UI

/// Represents a store front
public protocol StoreFrontKitDisplayable {
    /// Represents the product(s) to be displayed
    var sfkProduct: [StoreFrontProduct] { get set }

    /// Represents purchase completion callback
    var completion: SFKIAPManager.SFKPurchaseCompletion { get set }

    /// Represents display constructor
    /// - Parameters:
    ///   - product: Represents product to display
    ///   - completion: Completion callback for purchases
    init(with product: StoreFrontProduct, completion: @escaping SFKIAPManager.SFKPurchaseCompletion)

    /// Initiate product purchase
    /// - Parameter product: Product to be purchased
    func purchase(_ product: StoreFrontProduct)

    /// Initiate product restoration
    func restorePurchases()
}
