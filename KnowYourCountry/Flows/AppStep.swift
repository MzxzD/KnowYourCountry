//
//  AppStep.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case home
    case countryDetails(country: Country)
    case regional
}
