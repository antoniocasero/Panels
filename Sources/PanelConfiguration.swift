//
//  PanelConfiguration.swift
//  Panels-iOS
//
//  Created by Antonio Casero on 10.08.18.
//  Copyright © 2018 Panels. All rights reserved.
//

import Foundation
import UIKit

public struct PanelConfiguration {
    /// Panel height
    public var panelSize: PanelDimensions

    /// Panel margins between the header and the next views.
    public var panelMargin: CGFloat

    /// Visible area when the panel is collapsed
    public var panelVisibleArea: CGFloat

    /// Safe area is avoided if this flag is true.
    public var useSafeArea = true

    /// Collapse and expand when tapping the header view.
    public var respondToTap = true

    /// Collapse and expand when dragging the header view.
    public var respondToDrag = true

    /// Collapse when tapping outside the panel
    public var closeOutsideTap = true

    /// Animate the panel when the superview is shown.
    public var animateEntry = false

    /// If parent view is a navigationcontroller child, this flag allow a better
    /// calculation when the panelSize is .fullScreen
    public var enclosedNavigationBar = true

    /// This value sets defines the height constraint
    public var heightConstant: CGFloat?

    // Animation duration when the panel is presented
    public var entryAnimationDuration: Double = 1.0

    // Animation duration when the panel is dimissed
    public var dismissAnimationDuration: Double = 0.3

    /// Observe keyboard events
    public var keyboardObserver = true

    public init(size: PanelDimensions = .thirdQuarter,
                margin: CGFloat = 8.0,
                visibleArea: CGFloat = 64.0) {
        panelSize = size
        panelMargin = margin
        panelVisibleArea = visibleArea
    }

    internal func size(for view: UIView) -> CGFloat {
        let delta: CGFloat = (panelSize == .fullScreen) ? 0 : 2
        let screenSize = panelSize.translate(for: view, navController: enclosedNavigationBar)
        let size = useSafeArea ? screenSize + (UIApplication.safeAreaBottom() * delta) : screenSize
        return size
    }

    internal func visibleArea() -> CGFloat {
        let visible = panelVisibleArea + UIApplication.safeAreaBottom() + (panelMargin * 2)
        return visible
    }
}
