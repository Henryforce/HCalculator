//
//  AppStoreSnapshots.swift
//  LightCalculatorPlusUITests
//
//  Created by Henry Javier Serrano Echeverria on 14/6/21.
//  Copyright © 2021 Henry Serrano. All rights reserved.
//

import XCTest

final class AppStoreSnapshots: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLightSnapshot() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launchArguments.append("-lightMode") // Append instead of replace
        app.launch()
        
        snapshot("Main-Light")
    }
    
    func testDarkSnapshot() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launchArguments.append("-darkMode") // Append instead of replace
        app.launch()
        
        snapshot("Main-Dark")
    }

}
