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
    var panelConfiguration: PanelConfiguration!
    override func viewDidLoad() {
        super.viewDidLoad()
        panelConfiguration.panelSize = .custom(400)
        panelable = panelManager.addPanel(with: panelConfiguration, target: self)
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
