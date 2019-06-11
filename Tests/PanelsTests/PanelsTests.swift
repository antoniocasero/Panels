//
//  PanelTests.swift
//  Panels-iOS
//
//  Created by Antonio Casero on 15.08.18.
//  Copyright © 2018 Panels. All rights reserved.
//

@testable import Panels
import XCTest

class PanelTests: XCTestCase {
    class TestPanel: UIViewController, Panelable {
        var headerHeight: NSLayoutConstraint! = NSLayoutConstraint()
        var headerPanel: UIView! = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 80))
        var deinitCalled: (() -> Void)?
        deinit {
            deinitCalled?()
        }
    }

    class ParentVC: UIViewController {
        var deinitCalled: (() -> Void)?
        deinit {
            deinitCalled?()
        }
    }

    var parent: ParentVC!
    var panel: TestPanel!

    override func setUp() {
        panel = TestPanel()
        panel.view.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        parent = ParentVC()
        parent.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }

    override func tearDown() {
        parent = nil
        panel = nil
    }

    func testValidDefaultConfiguration() {
        let config = PanelConfiguration()
        XCTAssertNotNil(config)
        XCTAssertEqual(config.panelSize, .thirdQuarter)
        XCTAssertEqual(config.panelMargin, 8)
        XCTAssertTrue(config.useSafeArea)
    }

    func testPanelSizeWithoutNavBar() {
        let dimensions: PanelDimensions = .half
        let expectedDimension = dimensions.translate(for: panel.view, navController: false)
        XCTAssertEqual(expectedDimension, panel.view.bounds.height / 2)
    }

    func testPanelSizeWithNavBar() {
        let dimensions: PanelDimensions = .fullScreen
        let expectedDimension = dimensions.translate(for: parent.view, navController: true)
        XCTAssertEqual(expectedDimension, parent.view.bounds.height - 44)
    }

    func testPanelCreation() {
        let panelManager = Panels(target: parent)
        let config = PanelConfiguration(size: .half, visibleArea: 20)
        panelManager.show(panel: panel, config: config)
        XCTAssertEqual(parent.view.subviews.count, 1)
        XCTAssertFalse(panelManager.isExpanded)
        panelManager.expandPanel()
        XCTAssertTrue(panelManager.isExpanded)
    }

    func testPanelDismiss() {
        let panelManager = Panels(target: parent)
        let config = PanelConfiguration(size: .half, visibleArea: 20)
        panelManager.show(panel: panel, config: config)
        XCTAssertEqual(parent.view.subviews.count, 1)
        XCTAssertFalse(panelManager.isExpanded)
        let expDismiss = expectation(description: "Panel should be dismissed")
        panelManager.dismiss(completion: {
            XCTAssertEqual(self.parent.view.subviews.count, 0)
            expDismiss.fulfill()
        })
        waitForExpectations(timeout: 10)
    }

    func testCustomDimensions() {
        let d1: PanelDimensions = .custom(38.3)
        let d2: PanelDimensions = .custom(38.3)
        let d3: PanelDimensions = .custom(38.9)
        XCTAssertEqual(d1, d2)
        XCTAssertNotEqual(d1, d3)
    }

    func testPanelManagerDismissWithoutPanel() {
        let panelManager = Panels(target: parent)
        panelManager.show(panel: panel)
        let expDismiss = expectation(description: "Panel should be dismissed")
        panelManager.dismiss(completion: {
            expDismiss.fulfill()
        })
        waitForExpectations(timeout: 10)
        XCTAssertEqual(parent.view.subviews.count, 0)
    }
}
