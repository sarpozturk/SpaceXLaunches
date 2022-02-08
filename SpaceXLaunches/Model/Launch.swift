//
//  Launch.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 6.02.2022.
//

import Foundation

// MARK: - Launch
struct Launch: Codable, Hashable {
    let id, missionName: String?
    let launchDateLocal: String?
    let details: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id
        case missionName = "mission_name"
        case launchDateLocal = "launch_date_local"
        case details, links
    }
}

// MARK: - Links
struct Links: Codable, Hashable {
    let missionPatchSmall: String?
    let flickrImages: [String?]?

    enum CodingKeys: String, CodingKey {
        case missionPatchSmall = "mission_patch_small"
        case flickrImages = "flickr_images"
    }
}
