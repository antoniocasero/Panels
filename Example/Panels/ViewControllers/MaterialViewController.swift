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
        panelManager.addPanel(with: panelConfiguration, target: self)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
