//
//  HCalculatorTests.swift
//  HCalculatorTests
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import XCTest
@testable import LightCalculatorPlus

class HCalculatorTests: XCTestCase {

    var sut: ContentViewModel!
    
    override func setUpWithError() throws {
        sut = ContentViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testDefaultValueIsZero() throws {
        // When no action is executed
        // Then
        XCTAssertEqual(sut.calculationResult, "0")
    }

    func testPressingNumbersAppendsNumbersOnResultValue() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.threeWasPressed()
        sut.fourWasPressed()
        sut.fiveWasPressed()
        sut.sixWasPressed()
        sut.sevenWasPressed()
        sut.eightWasPressed()
        sut.nineWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "123456789")
    }
    
    func testMaximumNumberOfDigits() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.threeWasPressed()
        sut.fourWasPressed()
        sut.fiveWasPressed()
        sut.sixWasPressed()
        sut.sevenWasPressed()
        sut.eightWasPressed()
        sut.nineWasPressed()
        sut.zeroWasPressed() // This will be discarded
        
        // Then
        XCTAssertEqual(sut.calculationResult, "123456789")
    }
    
    func testPressingNumbersAppendsNumbersAndDeletingMoreNumbersThanAvailableDefaultsToZero() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.threeWasPressed()
        sut.fourWasPressed()
        sut.fiveWasPressed()
        sut.sixWasPressed()
        sut.sevenWasPressed()
        sut.eightWasPressed()
        sut.nineWasPressed()
        sut.zeroWasPressed()
        
        for _ in 0..<12 {
            sut.deleteWasPressed()
        }
        
        // Then
        XCTAssertEqual(sut.calculationResult, "0")
    }
    
    func testPressingNumbersAppendsNumbersAndPressingACDefaultsToZero() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.threeWasPressed()
        sut.fourWasPressed()
        sut.fiveWasPressed()
        sut.sixWasPressed()
        sut.sevenWasPressed()
        sut.eightWasPressed()
        sut.nineWasPressed()
        sut.zeroWasPressed()
        
        sut.ACWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "0")
    }
    
    func testChangeSignOfValueWithoutDecimalsDoesNotAddPoint() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.positiveNegativeWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "-12")
    }
    
    func testChangeSignOfValueWithDecimalsKeepsPoint() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.pointWasPressed()
        sut.zeroWasPressed()
        sut.fiveWasPressed()
        sut.positiveNegativeWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "-12.05")
    }
    
    func testChangeSignOfValueMultipleTimesReturnsExpectedSign() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.positiveNegativeWasPressed()
        sut.positiveNegativeWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "12")
    }
    
    func testMathActionWhenResultHasLastCharacterAsPointWorks() throws {
        // When
        sut.sevenWasPressed()
        sut.pointWasPressed()
        sut.plusWasPressed()
        sut.sixWasPressed()
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "13")
    }
    
    func testAdditionWhenMaximumNumbersArePutOnScreenAllowToRewrite() throws {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.threeWasPressed()
        sut.fourWasPressed()
        sut.fiveWasPressed()
        sut.sixWasPressed()
        sut.sevenWasPressed()
        sut.eightWasPressed()
        sut.nineWasPressed()
        
        sut.plusWasPressed()
        
        sut.fourWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "123456838")
    }
    
    func testAdditionOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()
        
        sut.plusWasPressed()
        
        sut.fourWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "87")
    }
    
    func testAdditionOnDecimalValuesAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.pointWasPressed()
        sut.eightWasPressed()
        
        sut.plusWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "8.7")
    }
    
    func testAdditionOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        
        sut.plusWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "7.9")
    }
    
    func testContinuousAdditionOperationsWithEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.plusWasPressed()
        sut.twoWasPressed()
        sut.plusWasPressed()
        sut.threeWasPressed()
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "6")
    }
    
    func testContinuousAdditionOperationsWithoutEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.plusWasPressed()
        sut.twoWasPressed()
        sut.plusWasPressed()
        sut.threeWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "3")
    }
    
    func testContinuousAdditionOperationsWithAdditionPressAtEnd() throws {
        // When
        sut.twoWasPressed()
        sut.plusWasPressed()
        sut.threeWasPressed()
        sut.plusWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "5")
    }
    
    func testSubstractionOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()
        
        sut.minusWasPressed()
        
        sut.fourWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "-11")
    }
    
    func testSubstractionOnDecimalValuesAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.pointWasPressed()
        sut.eightWasPressed()
        
        sut.minusWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "-1.1")
    }
    
    func testSubstractionOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        
        sut.minusWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "-1.9")
    }
    
    func testContinuousSubstractionOperationsWithEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.minusWasPressed()
        sut.twoWasPressed()
        sut.minusWasPressed()
        sut.threeWasPressed()
        sut.minusWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "-4")
    }
    
    func testContinuousSubstractionOperationsWithoutEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.minusWasPressed()
        sut.twoWasPressed()
        sut.minusWasPressed()
        sut.threeWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "3")
    }
    
    func testContinuousSubstractionOperationsWithAdditionPressAtEnd() throws {
        // When
        sut.twoWasPressed()
        sut.minusWasPressed()
        sut.threeWasPressed()
        sut.minusWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "-1")
    }
    
    func testMultiplicationOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()
        
        sut.multiplyWasPressed()
        
        sut.fourWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "1862")
    }
    
    func testMultiplicationOnDecimalValuesAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.pointWasPressed()
        sut.eightWasPressed()
        
        sut.multiplyWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "18.62")
    }
    
    func testMultiplicationOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        
        sut.multiplyWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "14.7")
    }
    
    func testContinuousMultiplicationOperationsWithEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.multiplyWasPressed()
        sut.twoWasPressed()
        sut.multiplyWasPressed()
        sut.threeWasPressed()
        sut.multiplyWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "6")
    }
    
    func testContinuousMultiplicationOperationsWithoutEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.multiplyWasPressed()
        sut.twoWasPressed()
        sut.multiplyWasPressed()
        sut.threeWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "3")
    }
    
    func testContinuousMultiplicationOperationsWithAdditionPressAtEnd() throws {
        // When
        sut.twoWasPressed()
        sut.multiplyWasPressed()
        sut.threeWasPressed()
        sut.multiplyWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "6")
    }
    
    func testDivisionOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()
        
        sut.divisionWasPressed()
        
        sut.fourWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "0.7755102")
    }
    
    func testDivisionOnDecimalValuesAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        sut.pointWasPressed()
        sut.eightWasPressed()
        
        sut.divisionWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "0.7755102")
    }
    
    func testDivisionOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() throws {
        // When
        sut.threeWasPressed()
        
        sut.divisionWasPressed()
        
        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "0.6122449")
    }
    
    func testContinuousDivisionOperationsWithEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.divisionWasPressed()
        sut.twoWasPressed()
        sut.divisionWasPressed()
        sut.threeWasPressed()
        sut.divisionWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "0.16666667")
    }
    
    func testContinuousDivisionOperationsWithoutEqualPressAtEnd() throws {
        // When
        sut.oneWasPressed()
        sut.divisionWasPressed()
        sut.twoWasPressed()
        sut.divisionWasPressed()
        sut.threeWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "3")
    }
    
    func testContinuousDivisionOperationsWithAdditionPressAtEnd() throws {
        // When
        sut.twoWasPressed()
        sut.divisionWasPressed()
        sut.threeWasPressed()
        sut.divisionWasPressed()
        
        // Then
        XCTAssertEqual(sut.calculationResult, "0.66666667")
    }

}
