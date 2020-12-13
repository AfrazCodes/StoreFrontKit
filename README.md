# StoreFrontKit

![StoreFrontKit Logo](https://raw.githubusercontent.com/AfrazCodes/StoreFrontKit/master/store_front_kit.png)

![StoreFrontKit Examples](https://raw.githubusercontent.com/AfrazCodes/StoreFrontKit/master/header.png)

## Introduction

Apple's StoreKit framework provides concise and clean APIs to interface with the App Store for in app purchases. However, a notable omission is a UI component to present in app purchases to users. The reasoning behind this is most likely that every app looks and feels different.

However, often times, we find ourselves writing a "Store Front" type component over  and over again. This UI encompasses information about the product, subscription, or service we are selling. Moreover, it gives the user a call to action to purchase, restore, or subscribe.

StoreFrontKit is a fully managed and lightweight framework to solve this. The framework accomplishes the following:
- Fully managed app store product fetching and caching
- Transaction management and purchase restorations
- Single item Store Front
- Multi item store Front
- Free trial subscription store front up sells
- Subscription group store front

## Installation

### CocoaPods

Include the following line in your `Podfile`

`pod 'StoreFrontKit'`

### Manual

You may download or clone this repo and use the source directly.

## Usage

There are 2 steps to use `StoreFrontKit`

### Configure at App Launch

First, you need to configure StoreFrontKit with the in app purchase product identifiers who want to manage in your app. The requirement is that this is done prior to using the storefront UIs. It is recommended you do this in your App Delegate as follows.

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set Up Store Front
        SFKManager.shared.configure(
            with: StoreFrontKitConfiguration(
                products: [
                    .nonConsumable(
                        productID: "com.example.item", viewModel: nil
                    ),
                    .subscription(
                        productID: "com.example.subscription", viewModel: nil
                    ),
                ]
            )
        )
        return true
    }
}
```

### Show Store Front

Creating a Store Front is as simple as creating and pushing a view controller.

```swift
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
```

In the above example, we create a single item (non-consumable) store front VC and push it. You'll also note that it takes a callback completion block. This block relays successful in app purchase transactions.

### More information

Check out the example app target included in this repo.

## Contributing

Contribution to this framework is not just welcomed, it is encouraged! Feel free to open Pull Requests or issues for feature requests and bug fixes. The ask is to follow a few rules:
- Build generic components that are not just specific to you
- Follow clean architecture principles
- Write testable code and related tests

## License

Distributed under MIT License
