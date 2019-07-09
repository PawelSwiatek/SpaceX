//
//  VehicleListViewController.swift
//  SpaceX
//
//  Created by Paweł Świątek on 24/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

protocol VehicleListViewControllerDisplayLogic {
    func showRocketImage(viewModel: VehicleListModel.Image.ViewModel)
}

class VehicleListViewController: UITableViewController {
    
    var interactor = VehicleListInteractor()
    
    // MARK: VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHelpers()
        setupView()
    }
    
    // MARK: Setup VC
    
    private func setupHelpers() {
        let presenter = VehicleListPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        
    }
    
    private func setupView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

//MARK : VehicleListViewControllerDisplayLogic

extension VehicleListViewController: VehicleListViewControllerDisplayLogic {
    
    func showRocketImage(viewModel: VehicleListModel.Image.ViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: TableView Data source

extension VehicleListViewController  {
    
    var dataSource: [RocketInfo] {
        return interactor.rocketInfo
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Strings.Cells.vehicleCellId, for: indexPath) as! VehicleListCell
        let rocketInfo = dataSource[indexPath.row]
        let rocketImage = rocketInfo.getRocketImage(interactor.rocketImages)
        
        if rocketImage?.image == nil {
            interactor.getRocketImage(request: VehicleListModel.Image.Request(urlString: rocketInfo.flickr_images?.first, rocketId: rocketInfo.id))
        }
        cell.setupCellWith(rocketInfo: rocketInfo, rocketImage: rocketImage?.image)
        
        return cell
    }
}


