//
//  LaunchPadsListPresenter.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

protocol LaunchPadsListPresentationLogic {
    func presentFetchResults(response: LaunchPadsListModel.FetchLaunchPads.Response)
    func presentFetchedImage(response: LaunchPadsListModel.FetchLaunchPadImage.Response)
    func presentErrorAlert(response: LaunchPadsListModel.FetchLaunchPads.Response)
    func presentAlert(response: LaunchPadsListModel.ShowAlert.Response)
}

class LaunchPadsListPresenter: LaunchPadsListPresentationLogic {
    
    var viewController: LaunchPadsListViewControllerDisplayLogic?
    
    //MARK : LaunchPadsListPresentationLogic

    func presentFetchResults(response: LaunchPadsListModel.FetchLaunchPads.Response) {
        let viewModel = LaunchPadsListModel.FetchLaunchPads.ViewModel()
        viewController?.successFetchedLaunchPads(viewModel: viewModel)
    }
    
    func presentFetchedImage(response: LaunchPadsListModel.FetchLaunchPadImage.Response) {
        let viewModel = LaunchPadsListModel.FetchLaunchPadImage.ViewModel(launchPadId: response.launchPadId, image: response.image)
        viewController?.successFetchingLaunchPadImage(viewModel: viewModel)
    }
    
    func presentErrorAlert(response: LaunchPadsListModel.FetchLaunchPads.Response) {
        let viewModel = LaunchPadsListModel.FetchLaunchPads.ViewModel(errorMessage: response.errorMessage)
        viewController?.fetchedWithError(viewModel: viewModel)
    }
    
    func presentAlert(response: LaunchPadsListModel.ShowAlert.Response) {
        let viewModel = LaunchPadsListModel.ShowAlert.ViewModel(alert: response.alert)
        viewController?.showErrorAlert(viewModel: viewModel)
    }
}



