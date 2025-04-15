//
//  CountryDetailsViewModel.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import Foundation
import RxCocoa
import RxFlow

class CountryDetailViewModel: Stepper, ObservableObject {
    let steps = PublishRelay<Step>()
    var country: Country

    init(country: Country) {
        self.country = country
    }
}
