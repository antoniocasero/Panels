//
//  UIViewController+Utils.swift
//  Panels-iOS
//
//  Created by Antonio Casero on 10.08.18.
//  Copyright © 2018 Panels. All rights reserved.
//

import UIKit

internal extension UIViewController {
    func hideKeyboardAutomatically() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

internal extension UIViewController {
    func addContainer(container: UIViewController) {
        addChild(container)
        view.addSubview(container.view)
        container.didMove(toParent: self)
    }

    func removeContainer() {
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
