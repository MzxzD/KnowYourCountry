//
//  CountryListError + Error.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 15.04.25.
//

import Foundation

enum CountryError: Error, Identifiable {
    var id: String {
        UUID().uuidString
    }
    
    case listError(String)

    var description: String {
        switch self {
            
        case .listError(let desc):
            return desc
        }
    }
}
