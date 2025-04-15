//
//  Country.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import Foundation

struct Country: Codable {
    let name: Name
    let flags: Flags
    let population: Int
    let region: String
    let area: Double
    let capital: [String]?
    let languages: [String: String]?
    
    struct Name: Codable, Hashable{
        let common: String
        let official: String
    }
    
    struct Flags: Codable, Hashable {
        let png: String
    }
}

extension Country {
    var formattedLanguages: String {
        guard let languages = languages else { return "N/A" }
        return languages.values.joined(separator: ", ")
    }
}

extension Country: Equatable, Hashable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.id == rhs.id
    }
}

extension Country: Identifiable {
    var id: String {
        name.common
    }
}
