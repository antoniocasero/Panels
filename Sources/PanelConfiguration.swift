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

    /// Storyboard name, the first viewcontroller will be instanciated
    public var panelName: String

    /// Panel height
    public var panelSize: PanelDimensions

    /// Panel margens between the header and the next views.
    public var panelMargen: CGFloat

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

    public var enclosedNavigationBar = true

    public init(storyboardName: String, size: PanelDimensions = .thirdQuarter, margen: CGFloat = 8.0, visibleArea: CGFloat = 64.0) {
        self.panelName = storyboardName
        self.panelSize = size
        self.panelMargen = margen
        self.panelVisibleArea = visibleArea
    }

    internal func size(for view: UIView) -> CGFloat {
        let delta: CGFloat = (panelSize == .fullScreen) ? 0 : 2
        let size = (self.useSafeArea) ? self.panelSize.translate(for: view, navController: enclosedNavigationBar) + (UIApplication.safeAreaBottom() * delta) : self.panelSize.translate(for: view, navController: enclosedNavigationBar)
        return size
    }

    internal func visibleArea() -> CGFloat {
        let visible = self.panelVisibleArea + UIApplication.safeAreaBottom() + (2 * panelMargen)
        return visible
    }

}
