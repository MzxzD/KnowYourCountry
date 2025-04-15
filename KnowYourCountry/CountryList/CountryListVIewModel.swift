//
//  CountryListVIewModel.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import Foundation
import RxSwift
import RxFlow
import RxCocoa
import Combine
import SwiftUI

class CountryListViewModel: RxFlow.Stepper, ObservableObject {
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let countryService: CountryServiceable
    
    // Input Output
    @Published var searchText: String = ""
    
    // Outputs
    @Published var countries: [Country] = []
    @Published var isLoading = false
    @Published var error: CountryError?
    
    var fetchedCountries: [Country] = []
    
    init(countryService: CountryServiceable) {
        self.countryService = countryService
        setupBindings()
    }
    
    private func setupBindings() {
        $searchText
            .throttle(for: .milliseconds(500), scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .map { [unowned self] query in
                guard !query.isEmpty else { return fetchedCountries }
                return self.fetchedCountries.filter { $0.name.official.contains(searchText) }
            }
            .assign(to: &$countries)
    }
    
    func fetchCountries() {
        guard fetchedCountries.isEmpty else { return }
        isLoading = true
        countryService.fetchCountries()
            .subscribe(
                onNext: { [weak self] countries in
                    let sorted = countries.sorted{ $0.name.common < $1.name.common }
                    self?.isLoading = false
                    self?.fetchedCountries = sorted
                    self?.countries = sorted
                },
                onError: { [weak self] error in
                    self?.isLoading = false
                    self?.error = error as? CountryError
                })
            .disposed(by: disposeBag)
    }
    
    func selectCountry(_ country: Country) {
        steps.accept(AppStep.countryDetails(country: country))
    }
}
