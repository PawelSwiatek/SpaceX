//
//  LaunchPadCell.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

class LaunchPadCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var statusLabel = UILabel()
    var thumbnailPhotoView = UIImageView()
    var imageActivityIndicator = UIActivityIndicatorView(style: .gray)
    
    //MARK: Setup Cell
    
    func setupCellWith(launchPadName: String?, launchStatus: String?, photo: UIImage?) {
        nameLabel.text = launchPadName
        statusLabel.text = launchStatus
        thumbnailPhotoView.image = photo
        setupCellsConstraints()
        showIndicatorIfNeeded()
    }
    
    private func showIndicatorIfNeeded() {
        if thumbnailPhotoView.image != nil {
            imageActivityIndicator.stopAnimating()
        } else {
            imageActivityIndicator.startAnimating()
        }
    }
    
    private func setupCellsConstraints() {
        
        addSubview(thumbnailPhotoView)
        addSubview(nameLabel)
        addSubview(statusLabel)
        thumbnailPhotoView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        thumbnailPhotoView.clipsToBounds = true
        thumbnailPhotoView.contentMode = .scaleAspectFill
        thumbnailPhotoView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        thumbnailPhotoView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        thumbnailPhotoView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        thumbnailPhotoView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        thumbnailPhotoView.widthAnchor.constraint(equalTo: thumbnailPhotoView.heightAnchor).isActive = true
        
        thumbnailPhotoView.addSubview(imageActivityIndicator)
        imageActivityIndicator.center = thumbnailPhotoView.center
        
        nameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: thumbnailPhotoView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: thumbnailPhotoView.trailingAnchor, constant: 10).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
    }
}



