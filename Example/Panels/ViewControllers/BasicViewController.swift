//
//  Example1ViewController.swift
//  Panels_Example
//
//  Created by Antonio Casero on 22.09.18.
//  Copyright © 2018 Antonio Casero. All rights reserved.
//

import UIKit
import Panels

class BasicViewController: UIViewController {
    let panelManager = Panels()
    override func viewDidLoad() {
        super.viewDidLoad()
        var panelConfiguration = PanelConfiguration(storyboardName: "PanelOptions")
        panelConfiguration.panelSize = .fullScreen
        panelManager.addPanel(with: panelConfiguration, target: self)
    }
}
