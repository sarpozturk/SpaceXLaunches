//
//  UIImageView+Extension.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 6.02.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {

    func downloadImage(from url: String) {
        let url = URL(string: url)
        self.kf.setImage(with: url)
    }
}
