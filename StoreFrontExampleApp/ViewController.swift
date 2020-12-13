//
//  ViewController.swift
//  StoreFrontExampleApp
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import StoreFrontKit
import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /// Table view subview
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return table
    }()

    struct Section {
        let title: String
        let options: [Option]
    }

    struct Option {
        let title: String
        let handler: (() -> Void)
    }

    private var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        title = "StoreFrontKit"
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func configureModels() {
        models.append(Section(title: "Standard", options: [
            Option(title: "Single Iteme", handler: { [weak self] in
                DispatchQueue.main.async {
                    let vc = SFKNonConsumableViewController(
                        with: .nonConsumable(
                            productID: Products.removeAds.rawValue,
                            viewModel: StoreFrontProductViewModel(
                                icon: UIImage(systemName: "x.square"),
                                iconTintColor: .systemPink
                            )
                        )
                    ) { result in
                        switch result {
                        case .success: break
                        case .failure: break
                        }
                    }
                    vc.title = "Remove Ads"
                    vc.navigationItem.largeTitleDisplayMode = .always
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }),
            Option(title: "Multiple Iteme", handler: { [weak self] in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    let header = UIView(frame: CGRect(x: 0, y: 0, width: strongSelf.view.frame.size.width, height: strongSelf.view.frame.size.width))
                    header.clipsToBounds = true
                    let imageView = UIImageView(frame: header.bounds)
                    header.addSubview(imageView)
                    imageView.image = UIImage(named: "header")
                    let vc = SFKMultiNonConsumableViewController(
                        with: [
                            .nonConsumable(
                                productID: Products.premium.rawValue,
                                viewModel: StoreFrontProductViewModel(
                                    icon: UIImage(systemName: "crown"),
                                    iconTintColor: .systemPurple
                                )
                            ),
                            .nonConsumable(
                                productID: Products.stickets.rawValue,
                                viewModel: StoreFrontProductViewModel(
                                    icon: UIImage(systemName: "star"),
                                    iconTintColor: .systemGreen
                                )
                            ),
                            .nonConsumable(
                                productID: Products.removeAds.rawValue,
                                viewModel: StoreFrontProductViewModel(
                                    icon: UIImage(systemName: "x.square"),
                                    iconTintColor: .systemPink
                                )
                            ),
                            .nonConsumable(
                                productID: Products.coins.rawValue,
                                viewModel: StoreFrontProductViewModel(
                                    icon: UIImage(systemName: "bitcoinsign.circle.fill"),
                                    iconTintColor: .systemOrange
                                )
                            )
                        ],
                        header: header
                    ) { result in
                        switch result {
                        case .success: break
                        case .failure: break
                        }
                    }
                    vc.title = "Upgrade"
                    vc.navigationItem.largeTitleDisplayMode = .never
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            })
        ]))

        models.append(Section(title: "Subscriptions", options: [
            Option(title: "Free Trial", handler: { [weak self] in
                DispatchQueue.main.async {
                    let vc = SFKSubscriptionTrialViewController(
                        with: .subscription(
                            productID: Products.subscriptionMonthly.rawValue,
                            viewModel: StoreFrontProductViewModel(
                                icon: UIImage(systemName: "x.square"),
                                iconTintColor: .systemPink
                            )
                        )
                    ) { result in
                        switch result {
                        case .success: break
                        case .failure: break
                        }
                    }
                    vc.title = "Remove Ads"
                    vc.navigationItem.largeTitleDisplayMode = .always
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }),
            Option(title: "Subscription Group", handler: { [weak self] in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    let header = UIView(frame: CGRect(x: 0, y: 0, width: strongSelf.view.frame.size.width, height: strongSelf.view.frame.size.width))
                    header.clipsToBounds = true
                    let imageView = UIImageView(frame: header.bounds)
                    header.addSubview(imageView)
                    imageView.image = UIImage(named: "header")
                    let vc = SFKMultiNonConsumableViewController(
                        with: [
                            .subscription(
                                productID: Products.subscriptionYearly.rawValue,
                                viewModel: StoreFrontProductViewModel(
                                    icon: UIImage(systemName: "x.square"),
                                    iconTintColor: .systemPink
                                )
                            ),
                            .subscription(
                                productID: Products.subscriptionMonthly.rawValue,
                                viewModel: StoreFrontProductViewModel(
                                    icon: UIImage(systemName: "x.square"),
                                    iconTintColor: .systemPink
                                )
                            ),
                            .subscription(
                                productID: Products.subscriptionQuarterly.rawValue,
                                viewModel: StoreFrontProductViewModel(
                                    icon: UIImage(systemName: "x.square"),
                                    iconTintColor: .systemPink
                                )
                            )
                        ],
                        header: header
                    ) { result in
                        switch result {
                        case .success: break
                        case .failure: break
                        }
                    }
                    vc.title = "Upgrade"
                    vc.navigationItem.largeTitleDisplayMode = .never
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            })
        ]))
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
}
