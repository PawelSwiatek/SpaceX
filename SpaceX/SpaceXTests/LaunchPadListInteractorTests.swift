//
//  LaunchPadListInteractorTests.swift
//  SpaceXTests
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import XCTest
@testable import SpaceX

class LaunchPadListInteractorTests: XCTestCase {
    let launchVC: LaunchPadsListViewController = LaunchPadsListViewController()

    
    func testInteraxtorLaunchPadDataSource() {
        let launchPads = [LaunchPad(id: 0, status: "status", location: LaunchPadLocation(name: "name", region: "region", latitude: 20, longitude: 20), vehicles_launched: [""], attempted_launches: 2, successful_launches: 0, wikipedia: "", details: "details", site_id: "id", site_name_long: "longname"), LaunchPad(id: 0, status: "status", location: LaunchPadLocation(name: "name", region: "region", latitude: 20, longitude: 20), vehicles_launched: [""], attempted_launches: 2, successful_launches: 0, wikipedia: "", details: "details", site_id: "id", site_name_long: "longname"),]
        NetworkingManager.sharedManager.delegate = launchVC.interactor
        NetworkingManager.sharedManager.delegate?.didDownloadLaunchPads(launchPads: launchPads)
        XCTAssert(launchVC.interactor.launchPadsData.count == 2, "dataSource should be the same as fetched data")
    }
    
    func testInteraxtorLaunchPadImagesDataSource() {
        let launchPadImages = LaunchPadImages(url: nil, launchPadId: 2, launchPadImage: UIImage())
        NetworkingManager.sharedManager.delegate = launchVC.interactor
        NetworkingManager.sharedManager.delegate?.didDownloadImageUrl(launchPadImage: launchPadImages)
        XCTAssert(launchVC.interactor.launchPadsImages.count == 1, "image dataSource should be the same as fetched data")
    }
}
