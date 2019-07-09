//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

//MARK : LaunchPad

struct LaunchPad: Decodable {
    let id: Int?
    let status: String?
    let location: LaunchPadLocation?
    let vehicles_launched: [String]?
    let attempted_launches: Int?
    let successful_launches: Int?
    let wikipedia: String?
    let details: String?
    let site_id: String?
    let site_name_long: String?
}

extension LaunchPad {
    func getLaunchPadImage(_ launchPadImages: [LaunchPadImages]) -> LaunchPadImages? {
        let launchPadObject = launchPadImages.filter{$0.launchPadId == self.id}.first
        
        return launchPadObject
    }
}

struct LaunchPadLocation: Decodable {
    let name: String?
    let region: String?
    let latitude: Double?
    let longitude: Double?
}

struct LaunchPadImages {
    let url: URL?
    let launchPadId: Int?
    var launchPadImage: UIImage?
}

//MARK : RocketInfo

struct RocketInfo: Decodable {
    let id: Int?
    let first_flight: String?
    let country: String?
    let company: String?
    let height: RocketHeight?
    let diameter: RocketDiameter?
    let mass: RocketMass?
    let flickr_images: [String]?
    let description: String?
    let rocket_name: String?
}

struct RocketImage {
    let image: UIImage
    let rocketId: Int
}

extension RocketInfo {
    func getRocketImage(_ rocketImages: [RocketImage]) -> RocketImage? {
        let rocketImages = rocketImages.filter{$0.rocketId == self.id}.first
        
        return rocketImages
    }
}

struct RocketHeight: Decodable {
    let meters: Double?
    let feet: Double?
}
struct RocketDiameter: Decodable {
    let meters: Double?
    let feet: Double?
}
struct RocketMass: Decodable {
    let kg: Double?
    let lb: Double?
}

