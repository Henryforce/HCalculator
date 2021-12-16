//
//  ContentView.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var state: AppState
    @ObservedObject var viewModel: ContentViewModel
    let numericPadViewModel: NumericPadViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .trailing, spacing: .zero) {
                
                VStack(alignment: .trailing, spacing: .zero) {
                    Text(self.viewModel.calculationResult)
                        .font(.system(size: min(geometry.size.width, geometry.size.height) * Constants.textHeight * 0.5 ))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.HBlue)
                        .lineLimit(1)
                        .accessibility(identifier: "Result")
                        .frame(minHeight: geometry.size.height * Constants.textHeight * 0.8)
                    Text(self.viewModel.spelledText)
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(Color.HBlue)
                }
                .frame(height: geometry.size.height * 0.3)
                
                NumericPadView(viewModel: numericPadViewModel)
                    .frame(height: geometry.size.height * 0.7)
                    .environmentObject(state)
                
            }
                
        }
        
    }
    
}

fileprivate struct Constants {
    static let textHeight: CGFloat = 0.21
    static let rowHeight: CGFloat = 0.11
}
