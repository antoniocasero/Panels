//
//  Panelable.swift
//  Panels-iOS
//
//  Created by Antonio Casero on 10.08.18.
//  Copyright © 2018 Panels. All rights reserved.
//

import UIKit

// Protocol to be conformed by the views presented as Panels.
public protocol Panelable: class {

    /// Constraint that controls the header panel height
    var headerHeight: NSLayoutConstraint! { get set }

    /// View container that contains the view that is presented when the panel is collapsed.
    var headerPanel: UIView! { get }
}

/// Protocol to get panel notifications. This protocol is optional. Useful when you want to concat
/// actions when the panel moves.
public protocol PanelNotifications: class {

    /// Notification when the panel is added to the container
    func panelDidPresented()

    /// Notification when the panel is collapsed.
    func panelDidCollapse()

    /// Notification when the panel is expanded.
    func panelDidOpen()
}
