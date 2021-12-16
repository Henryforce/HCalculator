//
//  ContentViewModelTests.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 16/12/21.
//  Copyright © 2021 Henry Serrano. All rights reserved.
//

import XCTest
@testable import LightCalculatorPlus

final class ContentViewModelTests: XCTestCase {

    var sut: ContentViewModel!
    
    override func setUpWithError() throws {
        sut = ContentViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testDefaultValues() {
        // When no action is executed
        // Then
        XCTAssertEqual(sut.calculationResult, "0")
        XCTAssertEqual(sut.spelledText, "...")
    }
    
}
