//
//  Example2ViewController.swift
//  Panels_Example
//
//  Created by Antonio Casero on 22.09.18.
//  Copyright © 2018 Antonio Casero. All rights reserved.
//

import UIKit
import Panels
class CustomViewController: UIViewController {
    let panelManager = Panels()
    var panelable: Panelable!
    override func viewDidLoad() {
        super.viewDidLoad()
        var panelConfiguration = PanelConfiguration(storyboardName: "PanelNotifications")
        panelConfiguration.panelSize = .custom(400)
        panelable = panelManager.addPanel(with: panelConfiguration, target: self)
    }
}
