//
//  LaunchPadListViewControllerTests.swift
//  SpaceXTests
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import XCTest
@testable import SpaceX

class LaunchPadListViewControllerTests: XCTestCase {
    let launchVC: LaunchPadsListViewController = LaunchPadsListViewController()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLaunchPadListViewControllerSetupHelpers() {
        launchVC.viewDidLoad()
        let ineractor = launchVC.interactor
        let presenter = ineractor.presenter
        let router = launchVC.router
        
        XCTAssertNotNil(ineractor, "viewController shouldn't be nil")
        XCTAssertNotNil(presenter, "presenter shouldn't be nil")
        XCTAssertNotNil(router, "router shouldn't be nil")
    }
    
    func testIfActivityIndicatorStarted() {
        launchVC.viewDidLoad()
        XCTAssert(launchVC.activityIndicator.isAnimating, "activity indicator should be started")
    }
}
