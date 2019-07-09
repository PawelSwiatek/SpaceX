//
//  NetworkingManager.swift
//  SpaceX
//
//  Created by Paweł Świątek on 22/06/2019.
//  Copyright © 2019 Paweł Świątek. All rights reserved.
//

import UIKit
import WikipediaKit

protocol LaunchPadsGetterProtocol {
    func didDownloadLaunchPads(launchPads: [LaunchPad])
    func didDownloadImageUrl(launchPadImage: LaunchPadImages)
    func didDownloadImage(image: UIImage, launchPadId: Int)
    func didDownloadRocketInfo(_ rocketInfo: [RocketInfo])
    func didDownloadWithError(message: String)
}

protocol RocketInfoImageGetterProtocol {
    func didDownloadRocketImage(image: UIImage, rocketId: Int)
}

class NetworkingManager {
    static var sharedManager = NetworkingManager()
    var delegate: LaunchPadsGetterProtocol?
    var rocketDelegate: RocketInfoImageGetterProtocol?
    
    private func fetch(url: URL, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            completionHandler(data, error)
        }
        dataTask.resume()
    }
    func fetchData() {
        fetchLaunchPads()
        fetchRocketInfo()
    }
    
    func fetchLaunchPads() {
        guard let launchPadsURL = URL(string: Constants.Strings.URLs.launchPadsUrl) else { return }
        fetch(url: launchPadsURL) { (data, error) in
            if let error = error {
                self.delegate?.didDownloadWithError(message: error.localizedDescription)
            } else {
                guard let data = data else { return }
                do {
                    let launchPads = try JSONDecoder().decode([LaunchPad].self, from: data)
                    self.delegate?.didDownloadLaunchPads(launchPads: launchPads)
                    
                    for launchPad in launchPads {
                        self.fetchLaunchPadImage(launchPad: launchPad)
                    }
                } catch let error {
                   self.delegate?.didDownloadWithError(message: error.localizedDescription)
                }
                
            }
        }
    }
    
    func getImageFromUrl(_ url: URL, launchPadId: Int) {
        fetch(url: url) { (data, error) in
            if let error = error {
                self.delegate?.didDownloadWithError(message: error.localizedDescription)
            } else {
                guard let data = data, let image = UIImage(data: data) else { return }
                self.delegate?.didDownloadImage(image: image, launchPadId: launchPadId)
                
            }
        }
    }
    
    func fetchRocketInfo() {
        guard let launchPadsURL = URL(string: Constants.Strings.URLs.allRocketUrl) else { return }
        fetch(url: launchPadsURL) { (data, error) in
            if let error = error {
                self.delegate?.didDownloadWithError(message: error.localizedDescription)
            } else {
                guard let data = data else { return }
                do {
                    let rocketInfo = try JSONDecoder().decode([RocketInfo].self, from: data)
                    self.delegate?.didDownloadRocketInfo(rocketInfo)
                } catch let error {
                    self.delegate?.didDownloadWithError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func getRocketImageFromUrl(_ url: URL, rocketId: Int) {
        fetch(url: url) { (data, error) in
            if let error = error {
                print(error)
            } else {
                guard let data = data, let image = UIImage(data: data) else { return }
                self.rocketDelegate?.didDownloadRocketImage(image: image, rocketId: rocketId)
            }
        }
    }
    
    func fetchLaunchPadImage(launchPad: LaunchPad) {
        guard let wikiString = launchPad.wikipedia else { return }
        let wikiImageTitle = wikiString.components(separatedBy: ("wiki/"))[1]
        let wiki = Wikipedia.shared
        let searchSessionTask = wiki.requestOptimizedSearchResults(language: WikipediaLanguage.init("en"), term: wikiImageTitle) { (searchResults, error) in
           
            if let error = error {
                self.delegate?.didDownloadWithError(message: error.localizedDescription)
            } else {
                guard let url = searchResults?.items.first?.imageURL else { return }
                print(url)
                let launchPadImage = LaunchPadImages(url: url, launchPadId: launchPad.id, launchPadImage: nil)
                self.delegate?.didDownloadImageUrl(launchPadImage: launchPadImage)
            }
        }
        searchSessionTask?.resume()
    }
}







