//
//  KnowYourCountryUITests.swift
//  KnowYourCountryUITests
//
//  Created by Mateo Doslic on 12.04.25.
//

import XCTest

final class KnowYourCountryUITests: XCTestCase {
    @MainActor
    func testWholeFlow() throws {
        
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery2 = app.collectionViews
        let collectionViewsQuery = collectionViewsQuery2
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.tap()
        app.navigationBars["Afghanistan"].buttons["ALL"].tap()
        
        let searchSearchField = app.navigationBars["ALL"].searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("Croatia")
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Republic of Croatia"]/*[[".cells.staticTexts[\"Republic of Croatia\"]",".staticTexts[\"Republic of Croatia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Croatia"].buttons["ALL"].tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        let europeButton = tabBar.buttons["EUROPE"]
        let allButton = tabBar.buttons["ALL"]
        europeButton.tap()
        
        let searchSearchField2 = app.navigationBars["EUROPE"].searchFields["Search"]
        searchSearchField2.tap()
        searchSearchField2.tap()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Republic of Austria"]/*[[".cells.staticTexts[\"Republic of Austria\"]",".staticTexts[\"Republic of Austria\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        europeButton.tap()
        allButton.tap()
        
        searchSearchField.tap()
        searchSearchField.typeText("Gibberish")
    }
}
