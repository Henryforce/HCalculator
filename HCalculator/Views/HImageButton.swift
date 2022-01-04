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
    var backgroundColor = Color.appBlue
    var titleColor = Color.appWhite
    
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
        HImageButton(systemName: "plus.slash.minus", backgroundColor: Color.appWhite, titleColor: Color.appBlue)
    }
    static var deleteButton: HImageButton {
        HImageButton(systemName: "delete.left", backgroundColor: Color.appWhite, titleColor: Color.appBlue)
    }
    static var equalButton: HImageButton {
        HImageButton(systemName: "equal", backgroundColor: Color.appOrange, titleColor: Color.appSemiblack)
    }
}
