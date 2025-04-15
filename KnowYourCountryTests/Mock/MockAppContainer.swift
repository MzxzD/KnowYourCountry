//
//  MockAppContainer.swift
//  KnowYourCountryTests
//
//  Created by Mateo Doslic on 15.04.25.
//

import Foundation
import Swinject
import Alamofire
import Mocker
@testable import KnowYourCountry

enum ContainerMockFlow {
    case normal
    case empty
    case error
}

extension AppContainer {    
    static func mock(flow: ContainerMockFlow) -> AppContainer {
        AppContainer(session: createMockedAFSession(for: flow))
    }
    
    private static func createMockedAFSession(for flow: ContainerMockFlow) -> Session {
        // Create Mock Session
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let session = Session(configuration: configuration)
        
        let AllCountriesApiEndpoint = URL(string: "https://restcountries.com/v3.1/all")!
        let europeApiEndpoint = URL(string: "https://restcountries.com/v3.1/region/europe")!
        
        switch flow {
        case .normal:
            // Create Mock response for all endpoint and register it
            let bundle = Bundle(for: self)
            let allCountriesPath = bundle.path(forResource: "allCountriesMock", ofType: "json")!
            let allCountriesPathJsonData = try! String(contentsOfFile: allCountriesPath, encoding: .utf8).data(using: .utf8)
            
            let mockAllCountriesResponse = Mock(
                url: AllCountriesApiEndpoint,
                contentType: .json,
                statusCode: 200,
                data: [.get: allCountriesPathJsonData!]
            )
            mockAllCountriesResponse.register()
            
            // Create Mock response for europe endpoint and register it
            let europePath = bundle.path(forResource: "Europe", ofType: "json")!
            let europeJsonData = try! String(contentsOfFile: europePath, encoding: .utf8).data(using: .utf8)
            let mockEuropeResponse = Mock(
                url: europeApiEndpoint,
                contentType: .json,
                statusCode: 200,
                data: [.get: europeJsonData!]
            )
            mockEuropeResponse.register()
            
        case .empty:
            let payload = "[\"]".data(using: .utf8)!
            
            let mockAllCountriesResponse = Mock(
                url: AllCountriesApiEndpoint,
                contentType: .json,
                statusCode: 200,
                data: [.get: payload]
                )
            mockAllCountriesResponse.register()
            
            let mockEuropeResponse = Mock(
                url: europeApiEndpoint,
                contentType: .json,
                statusCode: 200,
                data: [.get: payload]
            )
            mockEuropeResponse.register()
            
            
        case .error:
            let payload = "{\"status\": 404,\"message\": \"Not Found\"}".data(using: .utf8)!
            
            let mockAllCountriesResponse = Mock(
                url: AllCountriesApiEndpoint,
                statusCode: 404,
                data: [.get: payload]
                )
            mockAllCountriesResponse.register()
            
            let mockEuropeResponse = Mock(
                url: europeApiEndpoint,
                contentType: .json,
                statusCode: 404,
                data: [.get: payload]
            )
            mockEuropeResponse.register()
        }
        return session
    }
}
