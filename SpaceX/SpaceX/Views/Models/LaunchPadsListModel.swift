//
//  LaunchPadsListModel.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

struct LaunchPadsListModel {
    
    struct FetchLaunchPads {
        
        struct Request {
        }
        
        struct Response {
            var launchPads: [LaunchPad]?
            var errorMessage: String?
        }
        
        struct ViewModel {
            var errorMessage: String?
        }
    }
    
    struct FetchLaunchPadImage {
        
        struct Request {
            var url: URL
            var launchPadId: Int
        }
        
        struct Response {
            var launchPadId: Int
            var image: UIImage?
        }
        
        struct ViewModel {
            var launchPadId: Int
            var image: UIImage?
        }
    }
    
    struct LaunchPadImage {
        struct Request {
            var launchPadImage: LaunchPadImages
        }
        
        struct Response {
            var launchPadImage: UIImage
        }
        
        struct ViewModel {
            var launchPadImage: UIImage
        }
    }
    
    struct ShowAlert {
        struct Request {
            var errorMessage: String
        }
        
        struct Response {
            var alert: UIAlertController
        }
        
        struct ViewModel {
            var alert: UIAlertController
        }
    }
}

