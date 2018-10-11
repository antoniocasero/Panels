//
//  UIViewController+Utils.swift
//  Panels-iOS
//
//  Created by Antonio Casero on 10.08.18.
//  Copyright © 2018 Panels. All rights reserved.
//

import UIKit

internal extension UIViewController {

    internal func hideKeyboardAutomatically() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc internal func dismissKeyboard() {
        view.endEditing(true)
    }
}

internal extension UIViewController {
    
    func addContainer(container: UIViewController) {
        self.addChild(container)
        self.view.addSubview(container.view)
        container.didMove(toParent: self)
    }
    
    func removeContainer() {
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
}
