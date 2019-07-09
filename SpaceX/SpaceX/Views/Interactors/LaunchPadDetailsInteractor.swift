//
//  LaunchPadDetailsInteractor.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit
import MapKit

protocol LaunchPadDetailsBuisnessLogic {
    func setupDetailView(request: LaunchPadDetailsModel.SetupView.Request)
}

protocol LaunchPadDetailsDataStore {
    var launchPadData: LaunchPad { get set }
    var launchPadImage: UIImage? { get set }
    var rocketInfo: [RocketInfo]? { get set }
}

class LaunchPadDetailsInteractor: LaunchPadDetailsDataStore {
    var presenter: LaunchPadDetailsPresentationLogic?
    
    //MARK : LaunchPadsListDataStore

    var launchPadData: LaunchPad = LaunchPad(id: 0, status: "", location: LaunchPadLocation(name: "no Name", region: "no region", latitude: 0, longitude: 0), vehicles_launched: [], attempted_launches: 10, successful_launches: 0, wikipedia: "nope", details: "uknown", site_id: "", site_name_long: "no Long Name")
    var launchPadImage: UIImage?
    var rocketInfo: [RocketInfo]?
}

//MARK : LaunchPadDetailsBuisnessLogic

extension LaunchPadDetailsInteractor: LaunchPadDetailsBuisnessLogic {
    func setupDetailView(request: LaunchPadDetailsModel.SetupView.Request) {
        if let location = launchPadData.location {
            let locationText = getLocationText(launchLocation: location)
            let coordinates = setupCoordinates()
            let response = LaunchPadDetailsModel.SetupView.Response(name: launchPadData.site_name_long, status: launchPadData.status, detailText: launchPadData.details, locationText: locationText, image: launchPadImage, coordinates: coordinates)
            presenter?.presentDetails(response: response)
           
        }
    }
    
    func setupCoordinates() -> MKCoordinateRegion? {
        guard let latitude = launchPadData.location?.latitude, let longitude = launchPadData.location?.longitude else { return nil }
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 2000
        
        return MKCoordinateRegion(center: location.coordinate,
                           latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        
    }
    
    func getLocationText(launchLocation: LaunchPadLocation) -> String {
        guard let name = launchLocation.name, let region = launchLocation.region, let latitude = launchLocation.latitude, let longitude = launchLocation.longitude else { return "Launch Pad Location Unknown!"}
        let locationString = "Launch Pod Location:\nName: \(name)\nRegion: \(region)\nCoordinates: (\(latitude), \(longitude))"
        return locationString
    }
}

extension LaunchPadDetailsInteractor: LaunchPadImageGetterProtocol {
    func reloadImage(launchPadId: Int, image: UIImage) {
        if launchPadData.id == launchPadId {
            presenter?.stopAnimating(response: LaunchPadDetailsModel.UpdateImage.Response(image: image))
        }
    }
}

