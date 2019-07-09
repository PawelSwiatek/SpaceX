//
//  LaunchPadsListViewController.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit

protocol LaunchPadsListViewControllerDisplayLogic {
    func successFetchedLaunchPads(viewModel: LaunchPadsListModel.FetchLaunchPads.ViewModel)
    func fetchedWithError(viewModel: LaunchPadsListModel.FetchLaunchPads.ViewModel)
    func successFetchingLaunchPadImage(viewModel: LaunchPadsListModel.FetchLaunchPadImage.ViewModel)
    func showErrorAlert(viewModel: LaunchPadsListModel.ShowAlert.ViewModel)
}

class LaunchPadsListViewController: UITableViewController {
    
    var interactor = LaunchPadsListInteractor()
    var router = LaunchPadsListRouter()
    var activityIndicator = UIActivityIndicatorView(style: .gray)
    
// MARK: VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHelpers()
        setupViews()
        interactor.fetchLaunchPads(request: LaunchPadsListModel.FetchLaunchPads.Request())
    }
    
// MARK: Setup VC
    
    private func setupHelpers() {
        let presenter = LaunchPadsListPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    private func setupViews() {
        view.addSubview(activityIndicator)
        tableView.tableFooterView = UIView(frame: .zero)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
}

// MARK: LaunchPadsListViewControllerDisplayLogic

extension LaunchPadsListViewController: LaunchPadsListViewControllerDisplayLogic  {

    
    func successFetchedLaunchPads(viewModel: LaunchPadsListModel.FetchLaunchPads.ViewModel) {
        reloadTableView()
        stopActivityIndicator()
    }
    
    func successFetchingLaunchPadImage(viewModel: LaunchPadsListModel.FetchLaunchPadImage.ViewModel) {
        DispatchQueue.main.async {
            self.router.updateImage(launchPadId: viewModel.launchPadId, image: viewModel.image ?? UIImage())
        }
        reloadTableView()
    }
    
    func fetchedWithError(viewModel: LaunchPadsListModel.FetchLaunchPads.ViewModel) {
        interactor.showErrorAlert(request: LaunchPadsListModel.ShowAlert.Request(errorMessage: viewModel.errorMessage ?? "Error occured!"))
    }
    
    func showErrorAlert(viewModel: LaunchPadsListModel.ShowAlert.ViewModel) {
         present(viewModel.alert, animated: true)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
// MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Strings.Segues.segueToDetailsView {
            router.routeToDetailsView(segue: segue)
        }
    }
}


//MARK: TableView Data source

extension LaunchPadsListViewController  {
    
    var dataSource: [LaunchPad] {
        return interactor.launchPadsData
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Strings.Cells.launchPadsListCellId, for: indexPath) as! LaunchPadCell
        let launchPad = dataSource[indexPath.row]
        let launchPadImages = launchPad.getLaunchPadImage(interactor.launchPadsImages)
        let image = launchPadImages?.launchPadImage
        cell.setupCellWith(launchPadName: launchPad.site_name_long, launchStatus: launchPad.status, photo: image)
        
        return cell
    }
}




