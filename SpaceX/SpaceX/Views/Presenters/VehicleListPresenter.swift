//
//  VehicleListPresenter.swift
//  SpaceX
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

protocol VehicleListPresentationLogic {
    func showRocketImage(response: VehicleListModel.Image.Response)
}

class VehicleListPresenter: VehicleListPresentationLogic {
    
    var viewController: VehicleListViewController?
    
    //MARK : VehicleListPresentationLogic
    
    func showRocketImage(response: VehicleListModel.Image.Response) {
        viewController?.showRocketImage(viewModel: VehicleListModel.Image.ViewModel())
    }

}
