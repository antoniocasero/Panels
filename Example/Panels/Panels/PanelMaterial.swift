//
//  PanelMaterial.swift
//  Panels_Example
//
//  Created by Antonio Casero on 30.09.18.
//  Copyright © 2018 Antonio Casero. All rights reserved.
//

import UIKit
import Panels

class PanelMaterial: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        curveTopCorners()
        self.view.addBlurBackground()
    }
}
