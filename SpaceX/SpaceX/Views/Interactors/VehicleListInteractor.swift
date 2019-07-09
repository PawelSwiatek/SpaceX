//
//  VehicleListInteractor.swift
//  SpaceX
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

protocol VehicleListInteractorBuisnessLogic {
    func getRocketImage(request: VehicleListModel.Image.Request)
}

protocol VehicleListInteractorDataStore {
    var rocketInfo: [RocketInfo] { get set }
    var rocketImages: [RocketImage] { get set }
}

class VehicleListInteractor: VehicleListInteractorDataStore {
    
    var presenter: VehicleListPresenter?
    var worker = VehicleListWorker()
    
    //MARK : VehicleListInteractorDataStore
    
    var rocketInfo: [RocketInfo] = []
    var rocketImages: [RocketImage] = []
}

//MARK : VehicleListInteractorBuisnessLogic

extension VehicleListInteractor: VehicleListInteractorBuisnessLogic {

    func getRocketImage(request: VehicleListModel.Image.Request){
            worker.interactor = self
            worker.fetchRocketImage(request: request)
    }
    
    func getAlreadyFetchedImage(rocketId: Int) -> UIImage? {
        let rocketImageInfo = rocketImages.filter{$0.rocketId == rocketId}.first
      
        return rocketImageInfo?.image
    }
}

// MARK : RocketInfoImageGetterProtocol

extension VehicleListInteractor: RocketInfoImageGetterProtocol {
    
    func didDownloadRocketImage(image: UIImage, rocketId: Int) {
        rocketImages.append(RocketImage(image: image, rocketId: rocketId))
        presenter?.showRocketImage(response: VehicleListModel.Image.Response())
    }
}
