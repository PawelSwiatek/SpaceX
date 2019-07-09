//
//  VehicleListWorker.swift
//  SpaceX
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

class VehicleListWorker {
    var interactor: VehicleListInteractorBuisnessLogic?
    
    //  MARK: Worker fetch request
    
    func fetchRocketImage(request: VehicleListModel.Image.Request) {
        NetworkingManager.sharedManager.rocketDelegate = (interactor as! RocketInfoImageGetterProtocol)
        guard let string = request.urlString, let url = URL(string: string), let rocketId = request.rocketId else { return }
        NetworkingManager.sharedManager.getRocketImageFromUrl(url, rocketId: rocketId)
    }
}
