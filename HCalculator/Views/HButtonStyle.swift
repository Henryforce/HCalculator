//
//  HButtonStyle.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI

struct HButtonStyle: ButtonStyle {
    
    var foregroundColor = Color.HBlack
    var backgroundColor = Color.HOrange
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(16)
    }
    
    mutating func resetToActionDefault() {
        foregroundColor = Color.HBlack
        backgroundColor = Color.HOrange
    }
    
    mutating func changeToActionSelected() {
        foregroundColor = Color.HBlue
        backgroundColor = Color.HWhite
    }
    
}
