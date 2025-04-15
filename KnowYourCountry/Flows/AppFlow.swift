//
//  AppFlow.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import Foundation
import RxFlow
import SwiftUI

class AppFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UITabBarController = {
        let viewController = UITabBarController()
        viewController.view.backgroundColor = .systemBackground
        return viewController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .home:
            return navigateToHome()
        case .countryDetails(let country):
            return navigateToCountryDetails(country: country)
        case .regional:
            return navigateToRegional()
        }
    }
    
    private func navigateToHome() -> FlowContributors {

        let allCountriesListView = createCityListView(for: .all)
        let europeCountriesListView = createCityListView(for: .europe)
        
        rootViewController.viewControllers = [allCountriesListView.view , europeCountriesListView.view]
 
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: allCountriesListView.view, withNextStepper: allCountriesListView.viewModel),
            .contribute(withNextPresentable: europeCountriesListView.view, withNextStepper: europeCountriesListView.viewModel)
        ])
    }
    
    private func navigateToCountryDetails(country: Country) -> FlowContributors {
        let detailViewModel = AppContainer.shared.container.resolve(CountryDetailViewModel.self, argument: country)!

        let detailView = CountryDetailView(viewModel: detailViewModel)
        let detailViewController = UIHostingController(rootView: detailView)
        
        if let currentNavController = rootViewController.selectedViewController as? UINavigationController {
            currentNavController.pushViewController(detailViewController, animated: true)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: detailViewController, withNextStepper: detailViewModel))
    }
    
    private func navigateToRegional() -> FlowContributors {
        rootViewController.selectedIndex = CountryListType.europe.tag
        return .none
    }
    
    /// Builder for the list view of countries based on the region
    /// current implementation has all the countries and Europe
    /// - Parameter countryListType: List of the Countries that is groupped by region
    /// - Returns: Touple containing already set up NavigationController with CountryListView and the corresponding ViewModel
    private func createCityListView(for countryListType: CountryListType) -> (view: UINavigationController, viewModel: CountryListViewModel ){
        let viewModel = AppContainer.shared.container.resolve(CountryListViewModel.self, argument: countryListType)!
        let listView = AppContainer.shared.container.resolve(CountryListView.self, argument: viewModel)!
        let viewController = UIHostingController(rootView: listView)
        viewController.tabBarItem = UITabBarItem(
            title: countryListType.rawValue.uppercased(),
            image: countryListType.tabImage,
            tag: countryListType.tag
        )
        
        return (
            view: UINavigationController(rootViewController: viewController),
            viewModel: viewModel
        )
    }
}
