//
//  LaunchPadDetailsRouter.swift
//  SpaceX
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

@objc protocol LaunchPadDetailstRoutingLogic {
    func routeToVehicleListView(segue: UIStoryboardSegue?)
}

protocol LaunchPadDetailsDataPassing {
    var dataStore: LaunchPadDetailsDataStore? { get }
}

class LaunchPadDetailsRouter: LaunchPadDetailstRoutingLogic, LaunchPadDetailsDataPassing {
    
    weak var viewController: LaunchPadDetailsViewController?

// MARK: LaunchPadDetailsDataPassing
    
    var dataStore: LaunchPadDetailsDataStore?
    
// MARK: LaunchPadDetailstRoutingLogic
    
    func routeToVehicleListView(segue: UIStoryboardSegue?) {
        guard let destinationVC = segue?.destination as? VehicleListViewController else { return }
        let selectedRocketInfo = viewController?.interactor.rocketInfo ?? [RocketInfo]()
        passDataToDetailViewController(rocketInfo: selectedRocketInfo, destinationVC: destinationVC)
    }
    
//MARK: Passing Data
    
    private func passDataToDetailViewController(rocketInfo: [RocketInfo], destinationVC: VehicleListViewController) {
        destinationVC.interactor.rocketInfo = rocketInfo
    }
}

