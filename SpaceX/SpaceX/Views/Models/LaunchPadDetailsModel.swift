//
//  LaunchPadDetailsModel.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit
import MapKit

struct LaunchPadDetailsModel {
    
    struct SetupView {
        
        struct Request {
        }
        
        struct Response {
            var name: String?
            var status: String?
            var detailText: String?
            var locationText: String?
            var image: UIImage?
            var coordinates: MKCoordinateRegion?
        }
        
        struct ViewModel {
            var name: String?
            var status: String?
            var detailText: String?
            var locationText: String?
            var image: UIImage?
            var coordinates: MKCoordinateRegion?
        }
    }
    
    struct UpdateImage {
        
        struct Request {
        }
        
        struct Response {
            var image: UIImage
        }
        
        struct ViewModel {
            var image: UIImage
        }
    }
}

