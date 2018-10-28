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

    private weak var panel: (Panelable & UIViewController)?
    private weak var parentViewController: UIViewController?
    private weak var containerView: UIView?
    private weak var panelHeightConstraint: NSLayoutConstraint?
    private lazy var configuration: PanelConfiguration = PanelConfiguration()
    private var panelHeight: CGFloat = 0.0

    public init(target: UIViewController) {
        self.parentViewController = target
    }

    /// Add a viewcontainer to the view target. This subview is the panel definded in
    /// a storyboard and conform the protocol Panelable.
    /// - Parameters:
    ///   - config: Configuration panel, there you can define the panel behaviour
    ///   - target: Viewcontroller where the panel will be added as subview.
    ///   - view: Alternative view to viewController.view
    public func show(panel: Panelable & UIViewController,
                     config: PanelConfiguration = PanelConfiguration(),
                     view: UIView? = nil) {

        assert(self.panel == nil, "You are trying to push a panel without dismiss the previous one.")
        self.configuration = config
        self.containerView = view ?? parentViewController?.view
        self.panel = panel
        self.parentViewController?.addContainer(container: panel)
        guard let container = containerView else {
            fatalError("No parent view available")
        }

        panelHeightConstraint = self.addChildToContainer(parent: container,
                                                         child: panel.view,
                                                         visible: config.visibleArea(),
                                                         size: config.size(for: container))

        panel.hideKeyboardAutomatically()
        registerKeyboardNotifications()
        //Prepare the view placement, saving the safeArea.
        panelHeight = config.heightConstant ?? panel.headerHeight.constant
        panel.headerHeight.constant = panelHeight + UIApplication.safeAreaTop()
        setupGestures(headerView: panel.headerPanel, superview: container)
    }

    /// Opens the panel
    @objc public func expandPanel() {
        guard !isExpanded, let container = containerView else {
            return
        }
        movePanel(value: configuration.size(for: container))
    }

    /// Close the panel
    @objc public func collapsePanel() {
        guard isExpanded, let container = containerView else {
            return
        }
        movePanel(value: configuration.visibleArea())
        container.endEditing(true)
    }

    public func dismiss(completion: (() -> Void)? = nil) {
        self.panel?.headerHeight.constant = panelHeight
        guard let panelView = self.panel?.view else {
            return
        }

        UIView.animate(withDuration: configuration.dismissAnimationDuration, animations: {
            panelView.frame.origin = CGPoint(x: 0, y: self.containerView!.frame.size.height)
        }) { _ in
            self.panel?.removeContainer()
            completion?()
        }
        self.panel = nil

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Private functions

extension Panels {
    private func movePanel(value: CGFloat, keyboard: Bool = false, completion: (() -> Void)? = nil) {
        panelHeightConstraint?.constant = value
        if !keyboard {
            panel?.headerHeight.constant += isExpanded ? -(UIApplication.safeAreaBottom()) : UIApplication.safeAreaBottom()
        }
        isExpanded ? self.delegate?.panelDidOpen() : self.delegate?.panelDidCollapse()
        containerView?.animateLayoutBounce(completion: completion) ?? completion?()
    }

    private func addChildToContainer(parent container: UIView,
                                     child childView: UIView,
                                     visible: CGFloat,
                                     size: CGFloat) -> NSLayoutConstraint {
        childView.translatesAutoresizingMaskIntoConstraints = false
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
        if self.configuration.animateEntry {
            childView.animateLayoutBounce(duration: self.configuration.entryAnimationDuration)
        } else {
            childView.layoutIfNeeded()
        }
        self.delegate?.panelDidPresented()
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
            containerView.then {
                let currentValue = (isExpanded) ? configuration.size(for: $0) : configuration.visibleArea()
                movePanel(value: currentValue + keyboardHeight, keyboard: true)
            }
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

        if self.configuration.closeOutsideTap {
            let tapGestureOutside = UITapGestureRecognizer(target: self, action: #selector(collapsePanel))
            tapGestureOutside.cancelsTouchesInView = false
            containerView?.addGestureRecognizer(tapGestureOutside)
        }
    }

    @objc private func handleTap() {
        (isExpanded) ? collapsePanel() : expandPanel()
    }
}
