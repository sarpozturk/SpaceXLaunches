//
//  Network.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 4.02.2022.
//

import Foundation
import Apollo
import UIKit

protocol NetworkDelegate {
    func fetchLaunches(offset: Int, success: @escaping (_ launchs: [Launch]) -> Void, fail: @escaping (_ error: Error?) -> Void)
}

final class Network: NetworkDelegate {
    
    static let shared = Network()
    let cache = NSCache<NSString, UIImage>()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: Constants.API.base)!)
    
    func fetchLaunches(offset: Int, success: @escaping (_ launchs: [Launch]) -> Void, fail: @escaping (_ error: Error?) -> Void) {
        Network.shared.apollo.fetch(query: LaunchesPastQuery(offset: offset)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let launchesPast = graphQLResult.data?.launchesPast as? [LaunchesPastQuery.Data.LaunchesPast] {
                    success(self.transformToLaunchModelArray(launchesPast))
                }
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    private func transformToLaunchModelArray(_ model: [LaunchesPastQuery.Data.LaunchesPast]) -> [Launch] {
        return model.compactMap { launch in
            Launch(id: launch.id,
                   missionName: launch.missionName,
                   launchDateLocal: launch.launchDateLocal,
                   details: launch.details,
                   links: Links(missionPatchSmall: launch.links?.missionPatchSmall,
                                flickrImages: launch.links?.flickrImages))
        }
    }
}
