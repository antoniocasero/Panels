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
    lazy var panelManager = Panels(target: self)
    lazy var panel = UIStoryboard.instantiatePanel(identifier: "PanelOptions")
    override func viewDidLoad() {
        super.viewDidLoad()
        let panelConfiguration = PanelConfiguration(size: .oneThird)
        panelManager.show(panel: self.panel, config: panelConfiguration)
    }
}
