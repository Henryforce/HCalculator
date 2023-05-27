//
//  NumericPadViewModel.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 16/12/21.
//  Copyright © 2021 Henry Serrano. All rights reserved.
//

import Foundation
import SwiftUI

protocol NumericPadDelegate: AnyObject {
    func resultUpdated(_ result: NumericPadResult)
}

final class NumericPadViewModel: ObservableObject {
    
    @Published var plusButtonStyle = HButtonStyle()
    @Published var minusButtonStyle = HButtonStyle()
    @Published var multiplyButtonStyle = HButtonStyle()
    @Published var divisionButtonStyle = HButtonStyle()
    
    weak var delegate: NumericPadDelegate?
    
    private var calculationResultRaw: String = "0" {
        didSet {
            guard let result = NumericPadResult(from: calculationResultRaw, and: formatter) else { return }
            delegate?.resultUpdated(result)
        }
    }
    private lazy var lastValue = Decimal()
    private var areActionsEnabled = false
    private var stack = [MathAction]()
    private var shouldReplaceCurrentResult = false
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.alwaysShowsDecimalSeparator = false
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        formatter.locale = .init(identifier: "en_US")
        return formatter
    }()
    
    enum MathAction: Equatable {
        case addition
        case substraction
        case multiply
        case division
    }
    
    init(with delegate: NumericPadDelegate? = nil) {
        self.delegate = delegate
    }
    
    func keyWasPressed(key: String) {
        switch(key) {
        case "0": zeroWasPressed()
        case "1": oneWasPressed()
        case "2": twoWasPressed()
        case "3": threeWasPressed()
        case "4": fourWasPressed()
        case "5": fiveWasPressed()
        case "6": sixWasPressed()
        case "7": sevenWasPressed()
        case "8": eightWasPressed()
        case "9": nineWasPressed()
        case "+": plusWasPressed()
        case "-": minusWasPressed()
        case "/": divisionWasPressed()
        case "*": multiplyWasPressed()
        case ".": pointWasPressed()
        case "=", "\r", "\u{3}": equalWasPressed()
        case "\u{8}": deleteWasPressed()
        default: break
        }
    }
    
    func zeroWasPressed() {
        addNumberString(number: "0")
    }
    
    func oneWasPressed() {
        addNumberString(number: "1")
    }
    
    func twoWasPressed() {
        addNumberString(number: "2")
    }
    
    func threeWasPressed() {
        addNumberString(number: "3")
    }
    
    func fourWasPressed() {
        addNumberString(number: "4")
    }
    
    func fiveWasPressed() {
        addNumberString(number: "5")
    }
    
    func sixWasPressed() {
        addNumberString(number: "6")
    }
    
    func sevenWasPressed() {
        addNumberString(number: "7")
    }
    
    func eightWasPressed() {
        addNumberString(number: "8")
    }
    
    func nineWasPressed() {
        addNumberString(number: "9")
    }
    
    func ACWasPressed() {
        formatter.alwaysShowsDecimalSeparator = false
        calculationResultRaw = "0"
        stack.removeAll()
        resetButtons()
        areActionsEnabled = false
    }
    
    func positiveNegativeWasPressed() {
        guard let result = Decimal(string: calculationResultRaw) else { return }
        updateCalculationResult(from: result * -1)
    }
    
    func deleteWasPressed() {
        if !shouldReplaceCurrentResult, !calculationResultRaw.isEmpty {
            calculationResultRaw.removeLast()
            if calculationResultRaw.isEmpty {
                calculationResultRaw = "0"
            } else if !calculationResultRaw.contains(".") {
                formatter.alwaysShowsDecimalSeparator = false
            } else if calculationResultRaw.contains("."),
                      calculationResultRaw.split(separator: ".").count == 1 {
                formatter.alwaysShowsDecimalSeparator = false
                calculationResultRaw.removeLast()
            }
        }
    }
    
    func divisionWasPressed() {
        if areActionsEnabled, let currentValue = processCurrentValue() {
            addActionToStack(action: .division, with: currentValue)
            divisionButtonStyle.changeToActionSelected()
        }
    }
    
    func multiplyWasPressed() {
        if areActionsEnabled, let currentValue = processCurrentValue() {
            addActionToStack(action: .multiply, with: currentValue)
            multiplyButtonStyle.changeToActionSelected()
        }
    }
    
    func minusWasPressed() {
        if areActionsEnabled, let currentValue = processCurrentValue() {
            addActionToStack(action: .substraction, with: currentValue)
            minusButtonStyle.changeToActionSelected()
        }
    }
    
    func plusWasPressed() {
        if areActionsEnabled, let currentValue = processCurrentValue() {
            addActionToStack(action: .addition, with: currentValue)
            plusButtonStyle.changeToActionSelected()
        }
    }
    
    func pointWasPressed() {
        formatter.alwaysShowsDecimalSeparator = true
      
        // If there is an item in the stack and the point was pressed when the shouldReplace
        // variable is set, then manually replace the raw string with a 0 to keep the decimal
        // behavior consistent.
        if !stack.isEmpty, shouldReplaceCurrentResult {
            addNumberString(number: "0")
        }
      
        if !calculationResultRaw.contains(".") {
            let string = calculationResultRaw == "0" ? "0." : "."
            addNumberString(number: string)
        }
    }
    
    func equalWasPressed() {
        guard let currentValue = Decimal(string: calculationResultRaw) else { return }
        
        if let previousAction = stack.last {
            executeAction(action: previousAction, and: currentValue)
            stack.removeAll()
        }
    }
    
    private func addNumberString(number: String) {
        resetButtons()
        
        guard isTextReplaceable() else { return }
        
        if !calculationResultRaw.elementsEqual("0"), !shouldReplaceCurrentResult {
            calculationResultRaw += number
        } else {
            formatter.alwaysShowsDecimalSeparator = number == "0."
            calculationResultRaw = number
        }
        
        if shouldReplaceCurrentResult {
            resetButtons()
            shouldReplaceCurrentResult = false
        }
        areActionsEnabled = true
    }
    
    private func processCurrentValue() -> Decimal? {
        guard var currentValue = Decimal(string: calculationResultRaw) else { return nil }
        
        if let previousAction = stack.last, !shouldReplaceCurrentResult {
            executeAction(action: previousAction, and: currentValue)
            currentValue = Decimal(string: calculationResultRaw) ?? currentValue
        }
        
        return currentValue
    }
    
    private func addActionToStack(action: MathAction, with currentValue: Decimal) {
        stack.append(action)
        
        lastValue = currentValue
        shouldReplaceCurrentResult = true
    }
    
    private func executeAction(action: MathAction, and currentValue: Decimal) {
        let result: Decimal
        
        switch action {
        case .addition:
            result = lastValue + currentValue
        case .substraction:
            result = lastValue - currentValue
        case .multiply:
            result = lastValue * currentValue
        case .division:
            result = lastValue / currentValue
        }
        
        updateCalculationResult(from: result)
    }
    
    private func updateCalculationResult(from result: Decimal) {
        var stringValue = NSDecimalNumber(decimal: result).stringValue
        formatter.alwaysShowsDecimalSeparator = stringValue.contains(".")
            && stringValue.split(separator: ".").count > 1

        stringValue = stringValue.contains(".")
            ? String(stringValue.prefix(10))
            : String(stringValue.prefix(9))
        
        // Remove zeros on the right
        if stringValue.contains(".") {
            while let lastValue = stringValue.last, lastValue == "0" {
                stringValue.removeLast()
            }
        }
        
        calculationResultRaw = stringValue
    }
    
    private func resetButtons() {
        plusButtonStyle.resetToActionDefault()
        minusButtonStyle.resetToActionDefault()
        multiplyButtonStyle.resetToActionDefault()
        divisionButtonStyle.resetToActionDefault()
    }
    
    private func isTextReplaceable() -> Bool {
        shouldReplaceCurrentResult
            || (calculationResultRaw.contains(".") && calculationResultRaw.count < 10)
            || (!calculationResultRaw.contains(".") && calculationResultRaw.count < 9)
    }
    
}
