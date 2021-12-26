//
//  HCalculatorTests.swift
//  HCalculatorTests
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import XCTest
@testable import LightCalculatorPlus

final class NumericPadViewModelTests: XCTestCase {

    var sut: NumericPadViewModel!
    var delegate: MockNumericPadDelegate!
    
    override func setUpWithError() throws {
        delegate = MockNumericPadDelegate()
        sut = NumericPadViewModel(with: delegate)
    }

    override func tearDownWithError() throws {
        sut = nil
        delegate = nil
    }

    func testPressingNumbersAppendsNumbersOnResultValue() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "123,456,789")
    }
    
    func testPressingKeysAppendsNumbersOnResultValue() {
        // Given
        let keys = ["1", "2", "3", "4", "5", "+", "6", "-", "7", "/", "8", "*", "9", ".", "0", "=", "\u{8}", "\r", "\u{3}"]

        // When
        keys.forEach {
            sut.keyWasPressed(key: $0)
        }

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "1,388")
    }

    func testMaximumNumberOfDigits() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "123,456,789")
    }

    func testPressingNumbersAppendsNumbersAndDeletingMoreNumbersThanAvailableDefaultsToZero() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0")
    }

    func testPressingNumbersAppendsNumbersAndPressingACDefaultsToZero() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0")
    }

    func testChangeSignOfValueWithoutDecimalsDoesNotAddPoint() {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.positiveNegativeWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-12")
    }

    func testChangeSignOfValueWithDecimalsKeepsPoint() {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.pointWasPressed()
        sut.zeroWasPressed()
        sut.fiveWasPressed()
        sut.positiveNegativeWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-12.05")
    }

    func testChangeSignOfValueMultipleTimesReturnsExpectedSign() {
        // When
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.positiveNegativeWasPressed()
        sut.positiveNegativeWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "12")
    }

    func testMathActionWhenResultHasLastCharacterAsPointWorks() {
        // When
        sut.sevenWasPressed()
        sut.pointWasPressed()
        sut.plusWasPressed()
        sut.sixWasPressed()
        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "13")
    }

    func testAdditionWhenMaximumNumbersArePutOnScreenAllowToRewrite() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "123,456,838")
    }

    func testAdditionOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()

        sut.plusWasPressed()

        sut.fourWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "87")
    }

    func testPressPointFromStart() {
        // Given
        var resultStack = [String]()
        let expectedResultStack = ["0.", "0.5", "0.5", "2", "1"]

        // When
        sut.pointWasPressed()
        resultStack.append(delegate.resultUpdatedStack.last!.formattedString)
        sut.fiveWasPressed()
        resultStack.append(delegate.resultUpdatedStack.last!.formattedString)
        sut.multiplyWasPressed()
        resultStack.append(delegate.resultUpdatedStack.last!.formattedString)
        sut.twoWasPressed()
        resultStack.append(delegate.resultUpdatedStack.last!.formattedString)
        sut.equalWasPressed()
        resultStack.append(delegate.resultUpdatedStack.last!.formattedString)

        // Then
        XCTAssertEqual(expectedResultStack, resultStack)
    }

    func testAdditionOnDecimalValuesAddsDecimalPointOnSimpleOperation() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "8.7")
    }

    func testAdditionOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()

        sut.plusWasPressed()

        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "7.9")
    }

    func testContinuousAdditionOperationsWithEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.plusWasPressed()
        sut.twoWasPressed()
        sut.plusWasPressed()
        sut.threeWasPressed()
        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "6")
    }

    func testContinuousAdditionOperationsWithoutEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.plusWasPressed()
        sut.twoWasPressed()
        sut.plusWasPressed()
        sut.threeWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "3")
    }

    func testContinuousAdditionOperationsWithAdditionPressAtEnd() {
        // When
        sut.twoWasPressed()
        sut.plusWasPressed()
        sut.threeWasPressed()
        sut.plusWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "5")
    }

    func testSubstractionOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()

        sut.minusWasPressed()

        sut.fourWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-11")
    }

    func testSubstractionOnDecimalValuesAddsDecimalPointOnSimpleOperation() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-1.1")
    }

    func testSubstractionOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()

        sut.minusWasPressed()

        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-1.9")
    }

    func testContinuousSubstractionOperationsWithEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.minusWasPressed()
        sut.twoWasPressed()
        sut.minusWasPressed()
        sut.threeWasPressed()
        sut.minusWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-4")
    }

    func testContinuousSubstractionOperationsWithoutEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.minusWasPressed()
        sut.twoWasPressed()
        sut.minusWasPressed()
        sut.threeWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "3")
    }

    func testContinuousSubstractionOperationsWithAdditionPressAtEnd() {
        // When
        sut.twoWasPressed()
        sut.minusWasPressed()
        sut.threeWasPressed()
        sut.minusWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-1")
    }

    func testMultiplicationOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()

        sut.multiplyWasPressed()

        sut.fourWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "1,862")
    }

    func testMultiplicationOnDecimalValuesAddsDecimalPointOnSimpleOperation() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "18.62")
    }

    func testMultiplicationOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()

        sut.multiplyWasPressed()

        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "14.7")
    }

    func testContinuousMultiplicationOperationsWithEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.multiplyWasPressed()
        sut.twoWasPressed()
        sut.multiplyWasPressed()
        sut.threeWasPressed()
        sut.multiplyWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "6")
    }

    func testContinuousMultiplicationOperationsWithoutEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.multiplyWasPressed()
        sut.twoWasPressed()
        sut.multiplyWasPressed()
        sut.threeWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "3")
    }

    func testContinuousMultiplicationOperationsWithAdditionPressAtEnd() {
        // When
        sut.twoWasPressed()
        sut.multiplyWasPressed()
        sut.threeWasPressed()
        sut.multiplyWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "6")
    }

    func testDivisionOnIntegersValuesDoesNotAddDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()
        sut.eightWasPressed()

        sut.divisionWasPressed()

        sut.fourWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0.7755102")
    }

    func testDivisionOnDecimalValuesAddsDecimalPointOnSimpleOperation() {
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
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0.7755102")
    }

    func testDivisionOnIntegerAndDecimalAddsDecimalPointOnSimpleOperation() {
        // When
        sut.threeWasPressed()

        sut.divisionWasPressed()

        sut.fourWasPressed()
        sut.pointWasPressed()
        sut.nineWasPressed()

        sut.equalWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0.61224489")
    }

    func testContinuousDivisionOperationsWithEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.divisionWasPressed()
        sut.twoWasPressed()
        sut.divisionWasPressed()
        sut.threeWasPressed()
        sut.divisionWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0.16666666")
    }

    func testContinuousDivisionOperationsWithoutEqualPressAtEnd() {
        // When
        sut.oneWasPressed()
        sut.divisionWasPressed()
        sut.twoWasPressed()
        sut.divisionWasPressed()
        sut.threeWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "3")
    }

    func testContinuousDivisionOperationsWithAdditionPressAtEnd() {
        // When
        sut.twoWasPressed()
        sut.divisionWasPressed()
        sut.threeWasPressed()
        sut.divisionWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0.66666666")
    }

    func testDivisionOperationsWithBackspace() {
        // When
        sut.oneWasPressed()
        sut.divisionWasPressed()
        sut.threeWasPressed()
        sut.equalWasPressed()
        sut.deleteWasPressed()
        sut.deleteWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "0.333333")
    }

    func testDivisionOperationWithBackspaceDoesNotShowDecimalWhenDecimalNumbersAreAllRemoved() {
        // When
        sut.oneWasPressed()
        for _ in 0..<6 {
            sut.zeroWasPressed()
        }
        sut.divisionWasPressed()
        sut.zeroWasPressed()
        sut.pointWasPressed()
        sut.zeroWasPressed()
        sut.oneWasPressed()
        sut.twoWasPressed()
        sut.equalWasPressed()
        sut.deleteWasPressed()

        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "83,333,333")
    }

    func testZeroIsAvailable() {
        // When
        sut.oneWasPressed()
        sut.pointWasPressed()
        sut.zeroWasPressed()

        let firstResult = delegate.resultUpdatedStack.last!.formattedString

        sut.ACWasPressed()

        sut.threeWasPressed()
        sut.fiveWasPressed()
        sut.pointWasPressed()

        // Then
        XCTAssertEqual(firstResult, "1.0")
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "35.")
    }
    
    func testZerosAreAppendedToTheRight() {
        // When
        sut.oneWasPressed()
        sut.pointWasPressed()
        sut.zeroWasPressed()
        sut.zeroWasPressed()
        sut.zeroWasPressed()
        
        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "1.000")
    }
    
    func testZerosAreAppendedToTheRightAndRemovedOnMathOperations() {
        // When
        sut.oneWasPressed()
        sut.pointWasPressed()
        sut.zeroWasPressed()
        sut.zeroWasPressed()
        sut.zeroWasPressed()
        
        sut.multiplyWasPressed()
        
        sut.oneWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "1")
    }
    
    func testNegativeDivisionWithZeroAsInteger() {
        // When
        sut.fiveWasPressed()
        
        sut.positiveNegativeWasPressed()
        
        sut.divisionWasPressed()
        
        sut.sixWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-0.8333333")
    }
    
    func testNegativeDivisionWithOtherThanZeroAsInteger() {
        // When
        sut.sevenWasPressed()
        
        sut.positiveNegativeWasPressed()
        
        sut.divisionWasPressed()
        
        sut.sixWasPressed()
        
        sut.equalWasPressed()
        
        // Then
        XCTAssertEqual(delegate.resultUpdatedStack.last?.formattedString, "-1.1666666")
    }

}
