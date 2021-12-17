//
//  NumericPadResult.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 16/12/21.
//  Copyright © 2021 Henry Serrano. All rights reserved.
//

import Foundation

struct NumericPadResult {
    let formattedString: String
    let rawString: String
    let spelledString: String
    let decimalValue: Decimal
    
    init(
        formattedString: String,
        rawString: String,
        spelledString: String,
        decimalValue: Decimal
    ) {
        self.formattedString = formattedString
        self.rawString = rawString
        self.spelledString = spelledString
        self.decimalValue = decimalValue
    }
}

extension NumericPadResult {
    init?(from rawString: String, and formatter: NumberFormatter) {
        formatter.numberStyle = .decimal
        guard let decimal = Decimal(string: rawString),
              var formatted = formatter.string(from: NSDecimalNumber(decimal: decimal))
        else { return nil }

        // Handle the case where having a zero following the decimal point would be removed by the formatter.
        if rawString.contains(".0") && !formatted.contains(".0") {
            formatted += "0"
        }
        
        formatter.numberStyle = .spellOut
        guard let spell = formatter.string(from: NSDecimalNumber(decimal: decimal)) else { return nil }
        
        self.formattedString = formatted
        self.rawString = rawString
        self.spelledString = spell
        self.decimalValue = decimal
    }
}
