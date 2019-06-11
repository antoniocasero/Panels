//
//  PanelDimensions.swift
//  Panels
//
//  Created by Antonio Casero on 24.08.18.
//

import UIKit

/// Define the dimension of your panel (absolute size or relative size)
///
/// - oneThird: Expanded panel will fill one third of the container view.
/// - half: Expanded panel will fill half of the container view.
/// - thirdQuarter: Expanded panel will fill 3/4 of the container view.
/// - custom: Absolute size.

public enum PanelDimensions: Equatable {
    case oneThird
    case half
    case thirdQuarter
    case fullScreen
    case custom(CGFloat)

    func translate(for view: UIView, navController: Bool) -> CGFloat {
        switch self {
        case .oneThird:
            return view.bounds.height / CGFloat(3)
        case .half:
            return view.bounds.height / CGFloat(2)
        case .thirdQuarter:
            return view.bounds.height / CGFloat(1.5)
        case .fullScreen:
            let fullScreen = view.bounds.height
            let safeTop = UIApplication.safeAreaTop()
            let navBar: CGFloat = navController ? 44 : 0
            return fullScreen - safeTop - navBar
        case let .custom(customSize):
            return (customSize > view.bounds.height) ? view.bounds.width : customSize
        }
    }

    public static func == (lhs: PanelDimensions, rhs: PanelDimensions) -> Bool {
        switch (lhs, rhs) {
        case let (.custom(a), .custom(b)):
            return a == b
        case (.fullScreen, .fullScreen): fallthrough
        case (.thirdQuarter, .thirdQuarter): fallthrough
        case (.half, .half): fallthrough
        case (.oneThird, .oneThird):
            return true
        default:
            return false
        }
    }
}
