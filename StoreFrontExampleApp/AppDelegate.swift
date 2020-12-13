//
//  AppDelegate.swift
//  StoreFrontExampleApp
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import StoreFrontKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set Up Store Front
        SFKManager.shared.configure(
            with: StoreFrontKitConfiguration(
                products: [
                    .nonConsumable(
                        productID: Products.removeAds.rawValue, viewModel: nil
                    ),
                    .nonConsumable(
                        productID: Products.coins.rawValue, viewModel: nil
                    ),
                    .nonConsumable(
                        productID: Products.premium.rawValue, viewModel: nil
                    ),
                    .nonConsumable(
                        productID: Products.stickets.rawValue, viewModel: nil
                    ),
                    .subscription(
                        productID: Products.subscriptionQuarterly.rawValue, viewModel: nil
                    ),
                    .subscription(
                        productID: Products.subscriptionMonthly.rawValue, viewModel: nil
                    ),
                    .subscription(
                        productID: Products.subscriptionYearly.rawValue, viewModel: nil
                    )
                ]
            )
        )

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
