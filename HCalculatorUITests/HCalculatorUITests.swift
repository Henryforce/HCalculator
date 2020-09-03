//
//  HCalculatorUITests.swift
//  HCalculatorUITests
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import XCTest

class HCalculatorUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAllOperations() throws {
        // Given
        let app = XCUIApplication()
        app.launch()
        
        let additionLabel = app.buttons["+"]
        let button1 = app.buttons["1"]
        let button2 = app.buttons["2"]
        let button4 = app.buttons["4"]
        let button5 = app.buttons["5"]
        let button6 = app.buttons["6"]
        let buttonSubstraction = app.buttons["-"]
        let buttonMultiplication = app.buttons["X"]
        let buttonDivision = app.buttons["/"]
        let buttonEqual = app.buttons["="]
        let resultLabel = app.staticTexts["Result"]

        // When
        button1.tap()
        let button1PressedResult = resultLabel.label
        additionLabel.tap()
        let additionPressedResult = resultLabel.label
        button2.tap()
        let button2PressedResult = resultLabel.label
        buttonSubstraction.tap()
        let substractionPressedResult = resultLabel.label
        button4.tap()
        let button4PressedResult = resultLabel.label
        buttonMultiplication.tap()
        let multiplicationPressedResult = resultLabel.label
        button5.tap()
        let button5PressedResult = resultLabel.label
        buttonDivision.tap()
        let divisionPressedResult = resultLabel.label
        button6.tap()
        let button6PressedResult = resultLabel.label
        buttonEqual.tap()
        let finalResult = resultLabel.label
        
        // Then
        XCTAssertEqual(button1PressedResult, "1")
        XCTAssertEqual(additionPressedResult, "1")
        XCTAssertEqual(button2PressedResult, "2")
        XCTAssertEqual(substractionPressedResult, "3")
        XCTAssertEqual(button4PressedResult, "4")
        XCTAssertEqual(multiplicationPressedResult, "-1")
        XCTAssertEqual(button5PressedResult, "5")
        XCTAssertEqual(divisionPressedResult, "-5")
        XCTAssertEqual(button6PressedResult, "6")
        XCTAssertEqual(finalResult, "-0.83333333")
    }
    
}
