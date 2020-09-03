//
//  Color.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI

extension Color {
    public init(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(UIColor(red: r, green: g, blue: b, alpha: a))
                    return
                }
            }
        }
        
        self.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0))
    }
}

extension Color {
    static let HOrange = Color.init(hex: "#fbd46dff")
    static let HWhite = Color.init(hex: "#eeeeeeff")
    static let HBlack = Color.init(hex: "#222831ff")
    static let HBlue = Color.init(hex: "#4f8a8bff")
}
