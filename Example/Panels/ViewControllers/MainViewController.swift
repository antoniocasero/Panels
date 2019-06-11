//
//  ViewController.swift
//  Panels_Example
//
//  Created by Antonio Casero on 11.08.18.
//  Copyright © 2018 Antonio Casero. All rights reserved.
//

import Panels
import UIKit

class MainViewController: UIViewController {
    var customConfiguration = PanelConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func animationDidChange() {
        customConfiguration.animateEntry.toggle()
    }

    @IBAction func tapGestureDidChange() {
        customConfiguration.respondToTap.toggle()
    }

    @IBAction func dragGestureDidChange() {
        customConfiguration.respondToDrag.toggle()
    }

    @IBAction func closeAutomaticallyDidChange() {
        customConfiguration.closeOutsideTap.toggle()
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "custom" {
            guard let destination = segue.destination as? CustomViewController else {
                fatalError()
            }
            destination.panelConfiguration = customConfiguration
        }
    }
}
