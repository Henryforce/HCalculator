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
        
        // Split decimals and integers
        let splittedRawString = rawString.split(separator: ".")
        
        guard let fullDecimal = Decimal(string: rawString),
              let integerString = splittedRawString.first,
              let decimal = Decimal(string: String(integerString)),
              var formatted = formatter.string(from: NSDecimalNumber(decimal: decimal))
        else { return nil }
        
        // Make su
        if decimal.isZero, fullDecimal.isSignMinus {
            formatted = "-\(formatted)"
        }

        // Append decimal to formatted integers string if any
        if splittedRawString.count > 1 {
            let decimalString = splittedRawString[1]
            formatted += decimalString
        }
        
        formatter.numberStyle = .spellOut
        guard let spell = formatter.string(from: NSDecimalNumber(decimal: fullDecimal))
        else { return nil }
        
        self.formattedString = formatted
        self.rawString = rawString
        self.spelledString = spell
        self.decimalValue = decimal
    }
}
