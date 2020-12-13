//
//  SFKManager.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import Foundation

/// StoreFrontKit Manager responsible for global set up and management
public final class SFKManager {
    /// Shared instance
    public static let shared = SFKManager()

    /// Represents current configuraiton
    var configuration: StoreFrontKitConfiguration = StoreFrontKitConfiguration(products: [])

    /// Privatized constructor
    private init() {}

    /// Configure store front at app launch
    /// - Parameter configuration: Store front configuration
    public func configure(with configuration: StoreFrontKitConfiguration) {
        self.configuration = configuration
        fetchProductsFromAppStore()
    }

    // MARK: - Private

    /// Fetch store kit products from Apple
    private func fetchProductsFromAppStore() {
        SFKIAPManager.shared.fetchProductsFromAppStore()
    }
}
