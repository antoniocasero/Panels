//
//  UIStoryBoard+Utils.swift
//  Panels_Example
//
//  Created by Antonio Casero on 07.10.18.
//  Copyright © 2018 Antonio Casero. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    /// Helper method to initialize a panel using Storyboards
    ///
    /// - Parameter identifier: Name of the storyboard
    /// - Returns: The intial VC from the Storyboard that conforms Panelable
    class func instantiatePanel(identifier: String) -> Panelable & UIViewController {
        guard let panel = UIStoryboard(name: identifier, bundle: nil).instantiateInitialViewController() as? Panelable & UIViewController else {
            fatalError("Trying to instantiate something that does not conform Panelable :(")
        }
        return panel
    }
}
