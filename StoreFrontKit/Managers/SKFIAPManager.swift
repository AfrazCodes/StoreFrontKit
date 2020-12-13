//
//  SKFIAPManager.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import Foundation
import StoreKit

/// Represents In App Purchase Manager
public final class SFKIAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    /// Shared Instance
    static let shared = SFKIAPManager()

    /// Represents fetched products from Apple
    var appStoreProducts = Set<SKProduct>()

    /// Represents closure to be executed once app store products are ready
    private var whenReadyHandlers = [(() -> Void)]()

    /// Represents type for purchase completion callback handler
    public typealias SFKPurchaseCompletion = ((Result<String, Error>) -> Void)

    /// Represents purchase completion handler
    private var completion: SFKPurchaseCompletion?

    /// Represents current product being transacted
    private var transactingProduct: StoreFrontProduct?

    /// Represents StoreFront Kti transaction errors
    public enum SFKTransactionError: Error {
        /// Represents product resolution error
        case missingProduct
        /// Represents transaction failures in queue
        case transactionFailed
        /// Represents error for users who do not have a valid apple id set up
        case cannotMakePurchases
        /// Represents unknown error
        case unknown
    }

    // MARK: - Init

    /// Constructor override
    override init() {
        super.init()
        // Add transaction observer
        SKPaymentQueue.default().add(self)
    }

    /// Fetch store kit products from Apple
    /// Note: In dev environment please set up local store kit configuration
    func fetchProductsFromAppStore() {
        let request = SKProductsRequest(productIdentifiers: Set(SFKManager.shared.configuration.products.compactMap({ $0.identifier })))
        request.delegate = self
        request.start()
    }

    func purchase(product: StoreFrontProduct, completion: @escaping SFKPurchaseCompletion) {
        guard SKPaymentQueue.canMakePayments() else {
            completion(.failure(SFKTransactionError.cannotMakePurchases))
            return
        }

        guard let appStoreProduct = appStoreProducts.first(where: { $0.productIdentifier == product.identifier }) else {
            completion(.failure(SFKTransactionError.missingProduct))
            return
        }

        self.transactingProduct = product
        self.completion = completion

        whenAppStoreProductsReady {
            DispatchQueue.main.async {
                let payment = SKPayment(product: appStoreProduct)
                SKPaymentQueue.default().add(payment)
            }
        }
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // MARK: - Private

    private func whenAppStoreProductsReady(handler: @escaping (() -> Void)) {
        guard appStoreProducts.isEmpty else {
            handler()
            return
        }
        whenReadyHandlers.append(handler)
    }

    // MARK: - Store Kit Interface

    public func request(_ request: SKRequest, didFailWithError error: Error) {
        guard request is SKProductsRequest else {
            return
        }
        appStoreProducts = []
    }

    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        appStoreProducts = Set(response.products)
    }

    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing:
                break
            case .purchased:
                if let currentTransactingProduct = transactingProduct,
                   currentTransactingProduct.identifier == $0.payment.productIdentifier {
                    completion?(.success($0.payment.productIdentifier))
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                completion?(.failure(SFKTransactionError.transactionFailed))
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                SKPaymentQueue.default().finishTransaction($0)
            case .deferred:
                SKPaymentQueue.default().finishTransaction($0)
            @unknown default:
                break
            }
        }
    }

    public func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}
