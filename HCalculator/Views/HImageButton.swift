//
//  HImageButton.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 25/12/21.
//  Copyright © 2021 Henry Serrano. All rights reserved.
//

import SwiftUI

struct HImageButton: View {
    
    let systemName: String
    var backgroundColor = Color.HBlue
    var titleColor = Color.HWhite
    
    var body: some View {
        Image(systemName: systemName)
            .font(.title)
            .foregroundColor(titleColor)
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
    }
    
}

extension HImageButton {
    static var signButton: HImageButton {
        HImageButton(systemName: "plus.slash.minus", backgroundColor: Color.HWhite, titleColor: Color.HBlue)
    }
    static var deleteButton: HImageButton {
        HImageButton(systemName: "delete.left", backgroundColor: Color.HWhite, titleColor: Color.HBlue)
    }
    static var equalButton: HImageButton {
        HImageButton(systemName: "equal", backgroundColor: Color.HOrange, titleColor: Color.HBlack)
    }
}
