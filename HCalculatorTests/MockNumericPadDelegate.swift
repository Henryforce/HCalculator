//
//  MockNumericPadDelegate.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 16/12/21.
//  Copyright © 2021 Henry Serrano. All rights reserved.
//

import Foundation
@testable import LightCalculatorPlus

final class MockNumericPadDelegate: NumericPadDelegate {
    lazy var resultUpdatedStack = [NumericPadResult]()
    func resultUpdated(_ result: NumericPadResult) {
        resultUpdatedStack.append(result)
    }
}
