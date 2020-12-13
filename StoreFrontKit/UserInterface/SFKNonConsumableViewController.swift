//
//  SFKConsumableViewController.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import UIKit

/// Represents display for single non-consumabel item
public final class SFKNonConsumableViewController: UIViewController, StoreFrontKitDisplayable {
    /// Represents display associated products
    public var sfkProduct: [StoreFrontProduct]

    /// Represents completion handler
    public var completion: SFKIAPManager.SFKPurchaseCompletion

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private let buyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Buy Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()

    private let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restore Purchases", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

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
        addSubviews()
        configureUI()
        configureButtons()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        buyButton.frame = CGRect(
            x: 15,
            y: view.frame.size.height-100-view.safeAreaInsets.bottom,
            width: view.frame.size.width-30,
            height: 50
        ).integral

        restoreButton.frame = CGRect(
            x: 15,
            y: view.frame.size.height-50-view.safeAreaInsets.bottom,
            width: view.frame.size.width-30,
            height: 50
        ).integral

        iconImageView.frame = CGRect(
            x: (view.frame.size.width - (view.frame.size.width/1.5))/2,
            y: view.safeAreaInsets.top + 15,
            width: view.frame.size.width/1.5,
            height: view.frame.size.width/1.5
        ).integral

        let remainingHeight: CGFloat = view.frame.size.height - 100 - iconImageView.frame.maxY - view.safeAreaInsets.bottom
        descriptionLabel.frame = CGRect(
            x: 20,
            y: iconImageView.frame.maxY,
            width: view.frame.size.width - 40,
            height: remainingHeight/2
        ).integral

        priceLabel.sizeToFit()
        priceLabel.frame = CGRect(
            x: 10,
            y: descriptionLabel.frame.maxY + 5,
            width: view.frame.size.width - 20,
            height: remainingHeight/2
        ).integral
    }

    private func configureUI() {
        iconImageView.image = sfkProduct.first?.viewModel?.icon
        iconImageView.tintColor = sfkProduct.first?.viewModel?.iconTintColor
        guard let product = sfkProduct.first else {
            return
        }
        let storeKitProduct = SFKIAPManager.shared.appStoreProducts.first(where: { $0.productIdentifier == product.identifier })
        descriptionLabel.text = storeKitProduct?.localizedDescription
        priceLabel.text = "\(storeKitProduct?.priceLocale.currencySymbol ?? "$")" + "\(storeKitProduct?.price ?? NSDecimalNumber(value: 0))"
    }

    private func addSubviews() {
        view.addSubview(iconImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(priceLabel)
        view.addSubview(buyButton)
        view.addSubview(restoreButton)
    }

    private func configureButtons() {
        buyButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }

    @objc private func didTapBuy() {
        guard let product = sfkProduct.first else {
            return
        }
        purchase(product)
    }

    @objc private func didTapRestore() {
        restorePurchases()
    }

    // MARK: - StoreFront

    public func purchase(_ product: StoreFrontProduct) {
        SFKIAPManager.shared.purchase(product: product, completion: completion)
    }

    public func restorePurchases() {
        SFKIAPManager.shared.restorePurchases()
    }
}
