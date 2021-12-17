//
//  ContentViewModel.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import Foundation
import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var calculationResult: String = "0"
    @Published var spelledText: String = "..."
    
}

extension ContentViewModel: NumericPadDelegate {
    func resultUpdated(_ result: NumericPadResult) {
        calculationResult = result.formattedString
        spelledText = result.spelledString
    }
}
