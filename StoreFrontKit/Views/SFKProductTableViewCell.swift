//
//  SFKProductTableViewCell.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import UIKit

protocol SFKProductTableViewCellDelegate: AnyObject {
    func sfkProductTableViewCell(_ cell: SFKProductTableViewCell, didTapGetWith model: SFKProductTableViewCell.ViewModel, index: Int)
}

/// Represents table view cell for product item
final class SFKProductTableViewCell: UITableViewCell {
    /// Cell identifier
    static let identifier = "SFKProductTableViewCell"

    private var index = 0

    /// Delegate to notify of events
    weak var delegate: SFKProductTableViewCellDelegate?

    /// Represents cell viewModel
    struct ViewModel {
        let title: String
        let price: String
        let description: String
        let icon: UIImage?
        let iconTint: UIColor?
    }

    private var model: ViewModel?

    // MARK: - Subviews

    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        return label
    }()

    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()

    private let getButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6
        return button
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        selectionStyle = .none
        accessoryType = .none
        getButton.addTarget(self, action: #selector(didTapGet), for: .touchUpInside)
        contentView.addSubview(iconImageView)
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(getButton)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc private func didTapGet() {
        guard let model = model else { return }
        delegate?.sfkProductTableViewCell(self, didTapGetWith: model, index: index)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: 15, y: (contentView.frame.size.height-50)/2, width: 50, height: 50).integral
        getButton.frame = CGRect(x: contentView.frame.size.width-80, y: (contentView.frame.size.height-34)/2, width: 70, height: 34).integral

        productTitleLabel.sizeToFit()
        productTitleLabel.frame = CGRect(x: iconImageView.frame.maxX+5, y: 0, width: contentView.frame.size.width-80-iconImageView.frame.maxX, height: 35).integral
        productDescriptionLabel.frame = CGRect(x: iconImageView.frame.maxX+5, y: 35, width: contentView.frame.size.width-80-iconImageView.frame.maxX, height: 50).integral
        productPriceLabel.frame = CGRect(x: iconImageView.frame.maxX+5, y: 85, width: contentView.frame.size.width-80-iconImageView.frame.maxX, height: 35).integral
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productTitleLabel.text = nil
        productDescriptionLabel.text = nil
        productPriceLabel.text = nil
        iconImageView.tintColor = .clear
    }

    /// Configure cell with viewModel
    /// - Parameter viewModel: ViewModel to configure with
    func configure(with viewModel: ViewModel, index: Int) {
        self.index = index
        self.model = viewModel
        productTitleLabel.text = viewModel.title
        productDescriptionLabel.text = viewModel.description
        productPriceLabel.text = viewModel.price
        iconImageView.image = viewModel.icon
        iconImageView.tintColor = viewModel.iconTint
    }
}
