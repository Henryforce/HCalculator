//
//  ContentViewModel.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var calculationResult: String = "0"
    @Published var plusButtonStyle = HButtonStyle()
    @Published var minusButtonStyle = HButtonStyle()
    @Published var multiplyButtonStyle = HButtonStyle()
    @Published var divisionButtonStyle = HButtonStyle()

    private var lastValue = 0.0
    private var areActionsEnabled = false
    private var shouldReplaceCurrentResult = false
    private var stack = [MathAction]()
    
    enum MathAction: Equatable {
        case addition
        case substraction
        case multiply
        case division
    }
    
    init() { }
    
    // Mark: ContentViewModel
    
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
        calculationResult = "0"
        stack.removeAll()
        resetButtons()
        areActionsEnabled = false
    }
    
    func positiveNegativeWasPressed() {
        guard let result = Double(calculationResult) else { return }
        updateCalculationResult(from: result * -1.0)
    }
    
    func deleteWasPressed() {
        if !shouldReplaceCurrentResult, !calculationResult.isEmpty {
            calculationResult.removeLast()
            
            if calculationResult.isEmpty {
                calculationResult = "0"
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
        if !calculationResult.contains(".") {
            let string = calculationResult == "0" ? "0." : "."
            addNumberString(number: string)
        }
    }
    
    func equalWasPressed() {
        guard let currentValue = Double(calculationResult) else { return }
        
        if let previousAction = stack.last {
            executeAction(action: previousAction, and: currentValue)
            stack.removeAll()
        }
    }
    
    private func addNumberString(number: String) {
        resetButtons()
        
        guard isTextReplaceable() else { return }
        
        if !calculationResult.elementsEqual("0"), !shouldReplaceCurrentResult {
            calculationResult += number
        } else {
            calculationResult = number
        }
        
        if shouldReplaceCurrentResult {
            resetButtons()
            shouldReplaceCurrentResult = false
        }
        areActionsEnabled = true
    }
    
    private func processCurrentValue() -> Double? {
        guard var currentValue = Double(calculationResult) else { return nil }
        
        if let previousAction = stack.last, !shouldReplaceCurrentResult {
            executeAction(action: previousAction, and: currentValue)
            currentValue = Double(calculationResult) ?? currentValue
        }
        
        return currentValue
    }
    
    private func addActionToStack(action: MathAction, with currentValue: Double) {
        stack.append(action)
        
        lastValue = currentValue
        shouldReplaceCurrentResult = true
    }
    
    private func executeAction(action: MathAction, and currentValue: Double) {
        let result: Double
        
        switch action {
        case .addition:
            result = lastValue + currentValue
            break
        case .substraction:
            result = lastValue - currentValue
            break
        case .multiply:
            result = lastValue * currentValue
            break
        case .division:
            result = lastValue / currentValue
            break
        }
        
        updateCalculationResult(from: result.rounded(toPlaces: 8))
    }
    
    private func updateCalculationResult(from result: Double) {
        if result.truncatingRemainder(dividingBy: 1).isZero {
            calculationResult = String(Int(result))
        } else {
            calculationResult = String(result)
        }
    }
    
    private func resetButtons() {
        plusButtonStyle.resetToActionDefault()
        minusButtonStyle.resetToActionDefault()
        multiplyButtonStyle.resetToActionDefault()
        divisionButtonStyle.resetToActionDefault()
    }
    
    private func isTextReplaceable() -> Bool {
        shouldReplaceCurrentResult
            || (calculationResult.contains(".") && calculationResult.count < 10)
            || (!calculationResult.contains(".") && calculationResult.count < 9)
    }
    
}
