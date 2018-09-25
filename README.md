# Panels

[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![Twitter](https://img.shields.io/badge/twitter-@acaserop-blue.svg?style=flat)](http://twitter.com/acaserop)


Panels is a framework to easily add sliding panels to your application.
It takes care the safe area in new devices and moving your panel when keyboard
is presented/dismissed.

Updated to Swift 4.2

<p float="center">
    <img src="Resources/demo1.gif" width="237" height="471" alt="Sliding Panel demo1">
    <img src="Resources/demo2.gif" width="237" height="471" alt="Sliding Panel demo2">
</p>

## Usage

First create your own panel, you can use Interface Builder (freeform viewcontroller),
Make sure that you conform the protocol 'Panelable'

```swift
import UIKit
import Panels

class PanelOptions: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
}
```
This protocol defines the interface needed to be able to adjust the sliding panel
to the container, expanding and collapsing. It will take care of the safe area


Then in your main viewcontroller, where the panel is presented:

```swift
    let panelManager = Panels()

    override func viewDidLoad() {
        super.viewDidLoad()
        var panelConfiguration = PanelConfiguration(storyboardName: "PanelOptions")
        panelConfiguration.panelSize = .oneThird
        panelManager.addPanel(with: panelConfiguration, target: self)
    }
}
```

## Installation

### CocoaPods

Add the line `pod "Panels"` to your `Podfile`

### Carthage
Add the line `github "antoniocasero/Panels"` to your `Cartfile`

## Author

Project created by Antonio Casero ([@acaserop](https://twitter.com/acaserop) on Twitter).