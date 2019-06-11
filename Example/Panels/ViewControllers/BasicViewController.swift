//
//  Example1ViewController.swift
//  Panels_Example
//
//  Created by Antonio Casero on 22.09.18.
//  Copyright © 2018 Antonio Casero. All rights reserved.
//

import Panels
import UIKit

class BasicViewController: UIViewController {
    lazy var panelManager = Panels(target: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        let panel = UIStoryboard.instantiatePanel(identifier: "PanelOptions")
        let panelConfiguration = PanelConfiguration(size: .custom(350))
        panelManager.show(panel: panel, config: panelConfiguration)
    }
}
