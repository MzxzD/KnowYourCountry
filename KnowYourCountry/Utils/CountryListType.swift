//
//  CountryListType.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 15.04.25.
//

import Foundation
import UIKit.UIImage

enum CountryListType: String, CaseIterable {
    case all
    case europe
}


extension CountryListType {
    var tabImage: UIImage? {
        switch self {
        case .all:
            return UIImage(systemName: "globe")
        case .europe:
            return UIImage(systemName: "map")
        }
    }
    
    var tag: Int {
        switch self {
        case .all:
            return 0
        case .europe:
            return 1
        }
    }
}
