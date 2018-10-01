//
//  MaterialPanleViewController.swift
//  Panels_Example
//
//  Created by Antonio Casero on 30.09.18.
//  Copyright © 2018 Antonio Casero. All rights reserved.
//

import UIKit
import Panels

class MaterialViewController: UIViewController {
    let panelManager = Panels()
    override func viewDidLoad() {
        super.viewDidLoad()
        var panelConfiguration = PanelConfiguration(storyboardName: "PanelMaterial")
        panelConfiguration.panelSize = .half
        panelConfiguration.animateEntry = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.panelManager.addPanel(with: panelConfiguration, target: self)
        }
    }
}
