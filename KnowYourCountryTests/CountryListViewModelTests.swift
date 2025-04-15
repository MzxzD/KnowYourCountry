//
//  CountryListViewModelTests.swift
//  KnowYourCountryTests
//
//  Created by Mateo Doslic on 15.04.25.
//

import Testing
import XCTest
@testable import KnowYourCountry

struct CountryListViewModelTests {    
    @Test func testNormalFlowForAll() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .normal)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.all)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1))
         
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count > 0)
        XCTAssertNil(sut.error)
    }
    
    @Test func testNormalFlowForEurope() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .normal)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.europe)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1))
         
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count > 0)
        XCTAssertNil(sut.error)
    }
    
    @Test func testEmptyResponseFlowForAll() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .empty)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.all)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1))
         
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count == 0)
        XCTAssertNil(sut.error)
    }
    
    @Test func testEmptyResponseFlowForEurope() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .empty)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.europe)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1))
         
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count == 0)
        XCTAssertNil(sut.error)
    }
    
    @Test func testErrorResponseFlowForAll() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .error)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.all)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1))
         
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count == 0)
        XCTAssertNotNil(sut.error)
    }
    
    @Test func testErrorResponseFlowForEurope() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .error)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.europe)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1))
         
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count == 0)
        XCTAssertNotNil(sut.error)
    }
    
    @Test func testSearchFlowForEurope() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .normal)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.europe)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1))
        sut?.searchText = "Croatia"
        try await Task.sleep(for: .seconds(1))
        
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count == 1)
        XCTAssertEqual(sut.countries.first?.name.official, "Croatia")
        XCTAssertNotNil(sut.error)
    }
    
    @Test func testSearchFlowForEuropeButGiggerish() async throws {
        //Given
        let appContainer = AppContainer.mock(flow: .normal)
        let sut = appContainer.container.resolve(CountryListViewModel.self, argument: CountryListType.europe)
        
         //When
         sut?.fetchCountries()
        try await Task.sleep(for: .seconds(1)) 
        sut?.searchText = "sdjhLSKJD"
        try await Task.sleep(for: .seconds(1))
        
         //Then
        guard let sut else {
            XCTFail("Failed to safely unwrap sut!")
            return
        }
        XCTAssertTrue(sut.countries.count == 0)
        XCTAssertNotNil(sut.error)
    }
    
}
