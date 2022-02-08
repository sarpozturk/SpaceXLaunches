//
//  String+Extension.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 8.02.2022.
//

import Foundation

extension String {
    func convertToDate() -> Date?  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return dateFormatter.date(from: self)
    }
}
