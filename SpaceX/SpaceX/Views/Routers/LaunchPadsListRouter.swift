//
//  LaunchPadsListRouter.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

@objc protocol LaunchPadsListRoutingLogic {
    func routeToDetailsView(segue: UIStoryboardSegue?)
}

protocol LaunchPadsListDataPassing {
    var dataStore: LaunchPadsListDataStore? { get }
}

protocol LaunchPadImageGetterProtocol {
    func reloadImage(launchPadId: Int, image: UIImage)
}
    
class LaunchPadsListRouter: NSObject, LaunchPadsListRoutingLogic, LaunchPadsListDataPassing {
    var dataStore: LaunchPadsListDataStore?
    weak var viewController: LaunchPadsListViewController?
    var delegate: LaunchPadImageGetterProtocol?
    
// MARK: TableViewRoutingLogic
    
    func routeToDetailsView(segue: UIStoryboardSegue?) {
        
        let selectedIndex = viewController?.tableView.indexPathForSelectedRow?.row ?? 0
        guard let selectedLaunchPad = viewController?.dataSource[selectedIndex] else { return }
        guard let destinationVC = segue?.destination as? LaunchPadDetailsViewController else { return }
        
        var image = UIImage()
        if let launchPadImage = viewController?.interactor.launchPadsImages, let img = selectedLaunchPad.getLaunchPadImage(launchPadImage)?.launchPadImage {
            image = img
        } else {
            delegate = destinationVC.interactor
        }
        
        var filteredRocketInfo: [RocketInfo] = []
        
        if let rocketInfo = viewController?.interactor.rocketInfo, let names = selectedLaunchPad.vehicles_launched {
           filteredRocketInfo = filterRocketInfo(rocketInfo, names: names)
        }
        passDataToDetailViewController(dataSource: selectedLaunchPad, image: image, rocketInfo: filteredRocketInfo, destinationVC: destinationVC)
    }
    
    func filterRocketInfo(_ rocketInfo: [RocketInfo], names: [String]) -> [RocketInfo] {
        let filtered = rocketInfo.filter { names.contains($0.rocket_name!) }
        
        return filtered
    }
    
    func updateImage(launchPadId: Int, image: UIImage) {
        delegate?.reloadImage(launchPadId: launchPadId, image: image)
    }
    
//MARK: Passing Data
    
    private func passDataToDetailViewController(dataSource: LaunchPad, image: UIImage?, rocketInfo: [RocketInfo]?, destinationVC: LaunchPadDetailsViewController) {
        destinationVC.interactor.launchPadData = dataSource
        destinationVC.interactor.launchPadImage = image
        destinationVC.interactor.rocketInfo = rocketInfo
    }
}
