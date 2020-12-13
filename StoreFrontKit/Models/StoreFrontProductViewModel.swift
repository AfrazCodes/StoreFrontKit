//
//  StoreFrontProductViewModel.swift
//  StoreFrontKit
//
//  Created by Afraz Siddiqui on 12/13/20.
//

import Foundation
import UIKit

/// Represents view model for given product
public struct StoreFrontProductViewModel {
    let icon: UIImage?
    let iconTintColor: UIColor

    /// Constructor
    /// - Parameters:
    ///   - icon: icon for product
    ///   - iconTintColor: icon tint
    public init(icon: UIImage?, iconTintColor: UIColor) {
        self.icon = icon
        self.iconTintColor = iconTintColor
    }
}
