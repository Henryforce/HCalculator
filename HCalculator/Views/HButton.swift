//
//  HButton.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI

struct HButton: View {
    
    var title: String
    var backgroundColor = Color.appBlue
    var titleColor = Color.appWhite
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.regular)
            .foregroundColor(titleColor)
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
    }
    
}

extension HButton {
    static var acButton: HButton {
        HButton(title: "AC", backgroundColor: Color.appWhite, titleColor: Color.appBlue)
    }
}
