//
//  LaunchPadDetailsViewController.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit
import MapKit

protocol LaunchPadDetailsViewControllerDisplayLogic {
    func updateView(viewModel: LaunchPadDetailsModel.SetupView.ViewModel)
    func stopAnimating(viewModel: LaunchPadDetailsModel.UpdateImage.ViewModel)
}

class LaunchPadDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var locationTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var vehicleListBarButton: UIBarButtonItem!
    
    var imageActivityIndicator = UIActivityIndicatorView(style: .gray)
    var interactor = LaunchPadDetailsInteractor()
    var router = LaunchPadDetailsRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHelpers()
        setupView()
    }
    
// MARK: Setup
    
    private func setupHelpers() {
        let presenter = LaunchPadDetailsPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    private func setupView() {
        imageView.addSubview(imageActivityIndicator)
        imageActivityIndicator.center = imageView.center
        interactor.setupDetailView(request: LaunchPadDetailsModel.SetupView.Request())
        showIndicatorIfNeeded()
    }
    
    private func showIndicatorIfNeeded() {
        if let img = imageView.image, img.size.width > .zero, img.size.height > .zero  {
            imageActivityIndicator.stopAnimating()
        } else {
            imageActivityIndicator.startAnimating()
        }
    }
}

//MARK : LaunchPadDetailsViewControllerDisplayLogic

extension LaunchPadDetailsViewController: LaunchPadDetailsViewControllerDisplayLogic {

    func stopAnimating(viewModel: LaunchPadDetailsModel.UpdateImage.ViewModel) {
        DispatchQueue.main.async {
            self.imageActivityIndicator.stopAnimating()
            self.imageView.image = viewModel.image
        }
    }
    
    func updateView(viewModel: LaunchPadDetailsModel.SetupView.ViewModel) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        detailTextView.text = viewModel.detailText
        locationTextView.text = viewModel.locationText
        imageView.image = viewModel.image
        
        if let coordinates = viewModel.coordinates {
            mapView.setRegion(coordinates, animated: true)
            mapView.isScrollEnabled = false
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates.center
            annotation.title = viewModel.name
            mapView.addAnnotation(annotation)
            mapView.isZoomEnabled = true
        }
        
        let rectToAvoid = CGRect(x: 0, y: 0, width: imageView.frame.width + 10, height: 40)
        let beizerPath = UIBezierPath.init(rect: rectToAvoid)
        detailTextView.textContainer.exclusionPaths = [beizerPath]
    }
    
// MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Strings.Segues.segueToVehicleList {
            router.routeToVehicleListView(segue: segue)
        }
    }
}

