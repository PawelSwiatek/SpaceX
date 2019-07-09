//
//  LaunchPadDetailsPresenter.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//
import UIKit

protocol LaunchPadDetailsPresentationLogic {
    func presentDetails(response: LaunchPadDetailsModel.SetupView.Response)
    func stopAnimating(response: LaunchPadDetailsModel.UpdateImage.Response)
}

class LaunchPadDetailsPresenter: LaunchPadDetailsPresentationLogic {
    
    var viewController: LaunchPadDetailsViewControllerDisplayLogic?
    
    //MARK : LaunchPadDetailsPresentationLogic
    
    func presentDetails(response: LaunchPadDetailsModel.SetupView.Response) {
        let viewModel = LaunchPadDetailsModel.SetupView.ViewModel(name: response.name
            , status: response.status, detailText: response.detailText, locationText: response.locationText, image: response.image, coordinates: response.coordinates)
        viewController?.updateView(viewModel: viewModel)
    }
    
    func stopAnimating(response: LaunchPadDetailsModel.UpdateImage.Response) {
        viewController?.stopAnimating(viewModel: LaunchPadDetailsModel.UpdateImage.ViewModel(image: response.image))
    }
}

