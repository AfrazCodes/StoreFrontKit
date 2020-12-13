//
//  SFKSubscriptionTrialViewController.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import UIKit

/// Represents display for subscription trial
public final class SFKSubscriptionTrialViewController: UIViewController, StoreFrontKitDisplayable {
    /// Represents display associated products
    public var sfkProduct: [StoreFrontProduct]

    /// Represents completion handler
    public  var completion: SFKIAPManager.SFKPurchaseCompletion

    // MARK: - Init

    public required init(with product: StoreFrontProduct, completion: @escaping SFKIAPManager.SFKPurchaseCompletion) {
        sfkProduct = [product]
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - StoreFront

    public func purchase(_ product: StoreFrontProduct) {
        SFKIAPManager.shared.purchase(product: product, completion: completion)
    }

    public func restorePurchases() {
        SFKIAPManager.shared.restorePurchases()
    }
}
