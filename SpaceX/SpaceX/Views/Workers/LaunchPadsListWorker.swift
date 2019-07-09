//
//  LaunchPadsListWorker.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

class LaunchPadsListWorker {
    var interactor: LaunchPadsListBuisnessLogic?
    
  //  MARK: Worker fetch request
    
    func fetchLaunchPads(request: LaunchPadsListModel.FetchLaunchPads.Request) {
        NetworkingManager.sharedManager.delegate = interactor
        NetworkingManager.sharedManager.fetchData()
    }
    
    func fetchLaunchPadImage(request: LaunchPadsListModel.FetchLaunchPadImage.Request) {
        NetworkingManager.sharedManager.delegate = interactor
        NetworkingManager.sharedManager.getImageFromUrl(request.url, launchPadId: request.launchPadId)
    }

    
}

