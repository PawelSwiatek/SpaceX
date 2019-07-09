//
//  VehicleListCell.swift
//  SpaceX
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

class VehicleListCell: UITableViewCell {
    
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var vehicleTextView: UITextView!
    var imageActivityIndicator = UIActivityIndicatorView(style: .gray)
    
    //MARK: Setup Cell
    
    func setupCellWith(rocketInfo: RocketInfo, rocketImage: UIImage?) {
        addSubview(imageActivityIndicator)
        imageActivityIndicator.center = center
       
        if rocketImage == nil {
            imageActivityIndicator.startAnimating()
        } else {
            imageActivityIndicator.stopAnimating()
        }
        vehicleImage?.image = rocketImage
        setupTextViewDetailedText(rocketInfo: rocketInfo)
    }
    
    func setupTextViewDetailedText(rocketInfo: RocketInfo) {
        guard let name = rocketInfo.rocket_name, let company = rocketInfo.company, let country = rocketInfo.country, let firstFlight = rocketInfo.first_flight, let diameterMeters = rocketInfo.diameter?.meters, let height = rocketInfo.height?.meters, let mass = rocketInfo.mass?.kg, let description = rocketInfo.description else {
            vehicleTextView.text = "Vehicle info uknown!"
            return }
        
        vehicleTextView.text = "Vehicle Info:\nName: \(name)\nCompany: \(company)\nCountry: \(country)\nFirst Flight: \(firstFlight)\nDimensions: \nDiameter [m]: \(diameterMeters)\nHeight [m]: \(height)\nMass [kg]: \(mass)\n\(description)"
    }
}

