//
//  AppContainer.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import Foundation
import Swinject

class AppContainer {
    static let shared = AppContainer()
    
    let container: Container
    
    private init() {
        container = Container()
        setupDependencies()
    }
    
    private func setupDependencies() {
        // Services
        container.register(CountryServiceable.self) { (_, countryType: CountryListType) in
            return CountryService(fetchType: countryType)
        }
        
        // ViewModels
        
        container.register(CountryListViewModel.self) { (resolver , countryListType: CountryListType) in
            let countryService = resolver.resolve(CountryServiceable.self, argument: countryListType)!
            
            return CountryListViewModel(countryService: countryService)
        }

        container.register(CountryDetailViewModel.self) { (_, country: Country) in
            return CountryDetailViewModel(country: country)
        }
        
        // Views
        container.register(CountryListView.self) { (resolver, viewModel: CountryListViewModel)  in
            // Not sure of this is nessescary but oh well
            CountryListView(viewModel: viewModel)
        }
        
        container.register(CountryDetailView.self) { (resolver, country: Country) in
            let viewModel = resolver.resolve(CountryDetailViewModel.self, argument: country)!
            return CountryDetailView(viewModel: viewModel)
        }

    }
}

