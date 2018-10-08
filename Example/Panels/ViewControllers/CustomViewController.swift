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
    lazy var panelManager = Panels(target: self)
    lazy var panel = UIStoryboard.instantiatePanel(identifier: "PanelDetails")
    var panelConfiguration: PanelConfiguration!
    override func viewDidLoad() {
        super.viewDidLoad()
        panelConfiguration.panelSize = .custom(400)
        panelManager.show(panel: panel, config: panelConfiguration)
        panelManager.delegate = self
    }
}

extension CustomViewController: PanelNotifications {
    func panelDidPresented() {
        print("Panel is presented")
    }

    func panelDidCollapse() {
        print("Panel did collapse")
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }

    func panelDidOpen() {
        print("Panel did open")
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
}
