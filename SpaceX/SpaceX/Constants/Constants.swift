//
//  Constants.swift
//  SpaceX
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

struct Constants {
    struct Strings {
        struct Segues {
            static let segueToDetailsView = "segueToDetailsView"
            static let segueToVehicleList = "segueToVehicleList"
        }
        
        struct Cells {
            static let launchPadsListCellId = "CellId"
            static let vehicleCellId = "VehicleListCell"
        }
        
        struct URLs {
            static let launchPadsUrl = "https://api.spacexdata.com/v3/launchpads"
            static let allRocketUrl = "https://api.spacexdata.com/v3/rockets"
        }
        
        struct Alert {
            static let alertTitle = "Error"
            static let okAlertAction = "Ok"
            static let  tryAgainAlertAction = "Try again"
        }
    }
}
