//
//  LaunchPadsListInteractor.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

protocol LaunchPadsListBuisnessLogic: LaunchPadsGetterProtocol {
    func fetchLaunchPads(request: LaunchPadsListModel.FetchLaunchPads.Request)
    func getLaunchPadImage(request: LaunchPadsListModel.LaunchPadImage.Request)
    func showErrorAlert(request: LaunchPadsListModel.ShowAlert.Request)
}

protocol LaunchPadsListDataStore {
    var launchPadsData: [LaunchPad] { get set }
    var launchPadsImages: [LaunchPadImages] { get set }
    var rocketInfo: [RocketInfo] { get set }
}

class LaunchPadsListInteractor: LaunchPadsListDataStore {
    
    var presenter: LaunchPadsListPresentationLogic?
    var worker = LaunchPadsListWorker()
    
    //MARK : LaunchPadsListDataStore
    
    var launchPadsData: [LaunchPad] = []
    var launchPadsImages: [LaunchPadImages] = []
    var rocketInfo: [RocketInfo] = []
}

//MARK: LaunchPadsListBuisnessLogic

extension LaunchPadsListInteractor: LaunchPadsListBuisnessLogic {
    
    func fetchLaunchPads(request: LaunchPadsListModel.FetchLaunchPads.Request) {
        worker.interactor = self
        worker.fetchLaunchPads(request: request)
    }
    
    func getLaunchPadImage(request: LaunchPadsListModel.LaunchPadImage.Request) {
        let launchPadObject = request.launchPadImage
        guard let url = launchPadObject.url else { return }
        worker.interactor = self
        worker.fetchLaunchPadImage(request: LaunchPadsListModel.FetchLaunchPadImage.Request(url: url, launchPadId: launchPadObject.launchPadId!))
    }
    
    func showErrorAlert(request: LaunchPadsListModel.ShowAlert.Request) {
        let alert = UIAlertController(title: Constants.Strings.Alert.alertTitle, message: request.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Strings.Alert.okAlertAction, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.Strings.Alert.tryAgainAlertAction, style: .default, handler: { (action: UIAlertAction) in
            self.fetchLaunchPads(request: LaunchPadsListModel.FetchLaunchPads.Request())
        }))
        presenter?.presentAlert(response: LaunchPadsListModel.ShowAlert.Response(alert: alert))
        
    }
}

//MARK : NetworkingManagerDelegate

extension LaunchPadsListInteractor: LaunchPadsGetterProtocol {
    
    func didDownloadLaunchPads(launchPads: [LaunchPad]) {
        let response = LaunchPadsListModel.FetchLaunchPads.Response(launchPads: launchPads, errorMessage: nil)
        self.launchPadsData = launchPads
        presenter?.presentFetchResults(response: response)
        
    }
    
    func didDownloadImageUrl(launchPadImage: LaunchPadImages) {
        self.launchPadsImages.append(launchPadImage)
        getLaunchPadImage(request: LaunchPadsListModel.LaunchPadImage.Request(launchPadImage: launchPadImage))
    }
    
    func didDownloadImage(image: UIImage, launchPadId: Int) {
        var launchPadObject = launchPadsImages.filter{$0.launchPadId == launchPadId}.first
        launchPadObject?.launchPadImage = image
        
        if let index = launchPadsImages.firstIndex(where: {$0.launchPadId == launchPadId}) {
            launchPadsImages.append(launchPadObject!)
            launchPadsImages.remove(at: index)
        }
        presenter?.presentFetchedImage(response: LaunchPadsListModel.FetchLaunchPadImage.Response(launchPadId: launchPadId, image: launchPadObject?.launchPadImage))
    }
    
    func didDownloadRocketInfo(_ rocketInfo: [RocketInfo]) {
        self.rocketInfo = rocketInfo
    }
    
    func didDownloadWithError(message: String) {
        presenter?.presentErrorAlert(response: LaunchPadsListModel.FetchLaunchPads.Response(launchPads: nil, errorMessage: message))
    }
}




