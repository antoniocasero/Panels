//
//  Created by Antonio Casero Palmero on 10.08.18.
//  Copyright © 2018 Panels. All rights reserved.
//

import UIKit

public class Panels {
    public weak var delegate: PanelNotifications?
    public var isExpanded: Bool {
        return (panelHeightConstraint?.constant ?? 0.0) > configuration.visibleArea()
    }

    private weak var panel: Panelable!
    private weak var parentViewController: UIViewController!
    private weak var containerView: UIView!
    private weak var panelHeightConstraint: NSLayoutConstraint?
    private var configuration: PanelConfiguration!
    internal var animator: UIViewPropertyAnimator = UIViewPropertyAnimator()

    public init() {}

    /// Add a viewcontainer to the view target. This subview is the panel definded in
    /// a storyboard and conform the protocol Panelable.
    /// - Parameters:
    ///   - config: Configuration panel, there you can define the panel behaviour
    ///   - target: Viewcontroller where the panel will be added as subview.
    /// - Returns:
    @discardableResult
    public func addPanel(with config: PanelConfiguration, target: UIViewController) -> Panelable {

        guard let panelController = UIStoryboard(name: config.panelName,
                                                 bundle: nil).instantiateInitialViewController()  else {
            fatalError("Could not find the panel")
        }

        guard let panel = panelController as? Panelable else {
            fatalError("Your panel does not conform to Panelable")
        }

        self.configuration = config
        self.parentViewController = target
        self.containerView = target.view
        self.panel = panel
        self.parentViewController.addChild(panelController)
        panelHeightConstraint = self.addChildToContainer(parent: self.containerView,
                                                         child: panelController.view,
                                                         visible: config.visibleArea(),
                                                         size: config.size(for: containerView))

        panelController.didMove(toParent: self.parentViewController)
        precondition(panel.headerHeight != nil, "The header height constraint is not set")
        precondition(panel.headerPanel != nil, "The header view is not set")

        panelController.hideKeyboardAutomatically()
        registerKeyboardNotifications()
        //Prepare the view placement, saving the safeArea.
        self.panel.headerHeight.constant += UIApplication.safeAreaBottom()
        setupGestures(headerView: panel.headerPanel, superview: containerView)
        return panel
    }

    /// Opens the panel
    @objc public func expandPanel() {
        guard isExpanded != true else {
            return
        }
        movePanel(value: configuration.size(for: containerView))
    }

    /// Close the panel
    @objc public func collapsePanel() {
        guard isExpanded != false else {
            return
        }
        movePanel(value: configuration.visibleArea())
        self.containerView.endEditing(true)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Private functions

extension Panels {
    private func movePanel(value: CGFloat, for keyboard: Bool = false) {
        panelHeightConstraint!.constant = value
        if !keyboard {
            panel.headerHeight.constant += isExpanded ? -(UIApplication.safeAreaBottom()) : UIApplication.safeAreaBottom()
        }
        isExpanded ? self.delegate?.panelDidOpen() : self.delegate?.panelDidCollapse()
        containerView.animateLayoutBounce()
    }

    private func addChildToContainer(parent container: UIView,
                                     child childView: UIView,
                                     visible: CGFloat,
                                     size: CGFloat) -> NSLayoutConstraint {
        childView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(childView)
        //Bottom
        childView.frame = CGRect(x: 0, y: container.bounds.maxY + configuration.visibleArea(), width: container.bounds.width, height: configuration.visibleArea())
        let views = ["childView": childView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                                   options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                   metrics: nil,
                                                                   views: views)
        container.addConstraints(horizontalConstraints)
        let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[childView(==\(size))]",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)

        container.addConstraints(heightConstraints)
        let constraint = container.bottomAnchor.constraint(equalTo: childView.topAnchor,
                                                           constant: visible)
        constraint.isActive = true
        self.delegate?.panelDidPresented()
        if self.configuration.animateEntry {
            container.animateLayoutBounce(duration:1)
        } else {
            container.layoutIfNeeded()
        }
        return constraint
    }
}

// MARK: Keyboard control
extension Panels {
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = CGFloat(keyboardRectangle.height)
            let currentValue = (isExpanded) ? configuration.size(for: containerView) : configuration.visibleArea()
            movePanel(value: currentValue + keyboardHeight, for: true)
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        collapsePanel()
    }
}

// MARK: Gesture control
extension Panels {
    private func setupGestures(headerView: UIView, superview: UIView) {
        // Expand and collapse:
        if self.configuration.respondToTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            headerView.addGestureRecognizer(tapGesture)
        }

        if self.configuration.respondToDrag {
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(expandPanel))
            swipeUp.direction = .up
            headerView.addGestureRecognizer(swipeUp)
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(collapsePanel))
            swipeDown.direction = .down
            headerView.addGestureRecognizer(swipeDown)
        }

        // Collapse when you tap outside the panel
        if self.configuration.closeOutsideTap {
            let tapGestureOutside = UITapGestureRecognizer(target: self, action: #selector(collapsePanel))
            tapGestureOutside.cancelsTouchesInView = false
            containerView.addGestureRecognizer(tapGestureOutside)
        }
    }

    @objc private func handleTap() {
        (isExpanded) ? collapsePanel() : expandPanel()
    }
}
