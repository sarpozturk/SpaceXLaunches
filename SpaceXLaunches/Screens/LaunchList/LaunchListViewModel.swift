//
//  LaunchListViewModel.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 5.02.2022.
//

import Foundation
import Apollo

protocol LaunchListViewModelDelegate: AnyObject {
    func fetchLaunchSuccess()
    func fetchLaunchFail(_ error: Error?)
}

class LaunchListViewModel {
    
    var launches = [Launch]()
    var launchesPastOffset = 0
    var hasMoreLaunches = true

    let network: NetworkDelegate
    weak var delegate: LaunchListViewModelDelegate?
    
    init(network: NetworkDelegate = Network()) {
        self.network = network
    }

    func fetchLaunches(offset: Int = 0) {
        network.fetchLaunches(offset: offset) { [weak self] launchs in
            guard let self = self else { return }
            if launchs.count < 10 {
                self.hasMoreLaunches = false
            }
            self.launchesPastOffset += 10
            self.launches.append(contentsOf: launchs)
            self.delegate?.fetchLaunchSuccess()
        } fail: { [weak self] error in
            self?.delegate?.fetchLaunchFail(error)
        }
    }
}

