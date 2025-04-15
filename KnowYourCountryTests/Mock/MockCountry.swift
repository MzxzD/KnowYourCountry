//
//  MockCountry.swift
//  KnowYourCountryTests
//
//  Created by Mateo Doslic on 15.04.25.
//

import Foundation

extension Country {
    static var mock: Country {
        .init(
            name: .init(
                common: "Croatia",
                official: "Republic of Croatia"
            ),
            flags: .init(png: ""),
            population: 4047200, // this is waaaaay outdated xD
            region: "Europe",
            area: 56594.0,
            capital: ["Zagreb"],
            languages: ["hrv": "Croatian"]
        )
    }
}
