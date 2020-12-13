//
//  SFKMultiConsumableViewController.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import UIKit

/// Store front for multiple products
public final class SFKMultiNonConsumableViewController: UIViewController, StoreFrontKitDisplayable, UITableViewDelegate, UITableViewDataSource {
    /// Represents products
    public var sfkProduct: [StoreFrontProduct]

    /// Purchase completion
    public var completion: SFKIAPManager.SFKPurchaseCompletion

    /// Represents list table subview
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            SFKProductTableViewCell.self,
            forCellReuseIdentifier: SFKProductTableViewCell.identifier
        )
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return tableView
    }()

    // MARK: - Init

    public required init(with product: StoreFrontProduct, completion: @escaping SFKIAPManager.SFKPurchaseCompletion) {
        sfkProduct = [product]
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }

    public init(with products: [StoreFrontProduct], header: UIView? = nil, footer: UIView? = nil, completion: @escaping SFKIAPManager.SFKPurchaseCompletion) {
        self.sfkProduct = products
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Table

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Products + restore purchases cell
        return sfkProduct.count + 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == sfkProduct.count {
            // Restore cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Restore Purchases"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .link
            return cell
        }
        let model = sfkProduct[indexPath.row]

        guard let appStoreProduct = SFKIAPManager.shared.appStoreProducts.first(where: {
            $0.productIdentifier == model.identifier
        }) else {
            fatalError("Failed to find app store product; Double check that you have registered this with SFK Configuration")
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SFKProductTableViewCell.identifier,
            for: indexPath
        ) as? SFKProductTableViewCell else {
            fatalError()
        }

        cell.configure(
            with: SFKProductTableViewCell.ViewModel(
                title: appStoreProduct.localizedTitle,
                price: "\(appStoreProduct.priceLocale.currencySymbol ?? "$")\(appStoreProduct.price)",
                description: appStoreProduct.localizedDescription,
                icon: model.viewModel?.icon,
                iconTint: model.viewModel?.iconTintColor
            ),
            index: indexPath.row
        )
        cell.delegate = self
        return cell
    }

    // MARK: - StoreFront

    public func purchase(_ product: StoreFrontProduct) {
        SFKIAPManager.shared.purchase(product: product, completion: completion)
    }

    public func restorePurchases() {
        SFKIAPManager.shared.restorePurchases()
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

extension SFKMultiNonConsumableViewController: SFKProductTableViewCellDelegate {
    func sfkProductTableViewCell(_ cell: SFKProductTableViewCell, didTapGetWith model: SFKProductTableViewCell.ViewModel, index: Int) {
        purchase(sfkProduct[index])
    }
}
