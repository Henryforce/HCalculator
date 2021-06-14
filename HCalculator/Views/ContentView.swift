//
//  ContentView.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI

struct ContentView: View, KeyInput {
    
    @EnvironmentObject var state: AppState
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .trailing) {
                
                VStack(alignment: .trailing) {
                    Text(self.viewModel.calculationResult)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.HBlue)
                        .accessibility(identifier: "Result")
                    Text(self.viewModel.spelledText)
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(Color.HBlue)
                }
                .frame(minHeight: geometry.size.height * Constants.textHeight)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 4, trailing: 16))
                .onAppear {
                    self.state.delegate = self
                }
                
                HStack(spacing: 10) {
                    Button(action: {
                        self.viewModel.ACWasPressed()
                    }, label: {
                        HButton.acButton
                    })
                    Button(action: {
                        self.viewModel.positiveNegativeWasPressed()
                    }, label: {
                        HButton.signButton
                    })
                    Button(action: {
                        self.viewModel.deleteWasPressed()
                    }, label: {
                        HButton.deleteButton
                    })
                    Button(action: {
                        self.viewModel.divisionWasPressed()
                    }, label: {
                        Text("/")
                            .font(.title)
                            .fontWeight(.medium)
                    })
                    .buttonStyle(self.viewModel.divisionButtonStyle)
                }
                .frame(minHeight: geometry.size.height * Constants.rowHeight)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                
                HStack(spacing: 10) {
                    Button(action: {
                        self.viewModel.sevenWasPressed()
                    }, label: {
                        HButton(title: "7")
                    })
                    Button(action: {
                        self.viewModel.eightWasPressed()
                    }, label: {
                        HButton(title: "8")
                    })
                    Button(action: {
                        self.viewModel.nineWasPressed()
                    }, label: {
                        HButton(title: "9")
                    })
                    Button(action: {
                        self.viewModel.multiplyWasPressed()
                    }, label: {
                        Text("X")
                            .font(.title)
                            .fontWeight(.medium)
                    })
                    .buttonStyle(self.viewModel.multiplyButtonStyle)
                }
                .frame(minHeight: geometry.size.height * Constants.rowHeight)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                
                HStack(spacing: 10) {
                    Button(action: {
                        self.viewModel.fourWasPressed()
                    }, label: {
                        HButton(title: "4")
                    })
                    Button(action: {
                        self.viewModel.fiveWasPressed()
                    }, label: {
                        HButton(title: "5")
                    })
                    Button(action: {
                        self.viewModel.sixWasPressed()
                    }, label: {
                        HButton(title: "6")
                    })
                    Button(action: {
                        self.viewModel.minusWasPressed()
                    }, label: {
                        Text("-")
                            .font(.title)
                            .fontWeight(.medium)
                    })
                    .buttonStyle(self.viewModel.minusButtonStyle)
                }
                .frame(minHeight: geometry.size.height * Constants.rowHeight)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                
                HStack(spacing: 10) {
                    Button(action: {
                        self.viewModel.oneWasPressed()
                    }, label: {
                        HButton(title: "1")
                    })
                    Button(action: {
                        self.viewModel.twoWasPressed()
                    }, label: {
                        HButton(title: "2")
                    })
                    Button(action: {
                        self.viewModel.threeWasPressed()
                    }, label: {
                        HButton(title: "3")
                    })
                    Button(action: {
                        self.viewModel.plusWasPressed()
                    }, label: {
                        Text("+")
                            .font(.title)
                            .fontWeight(.medium)
                    })
                    .buttonStyle(self.viewModel.plusButtonStyle)
                }
                .frame(minHeight: geometry.size.height * Constants.rowHeight)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                
                HStack(spacing: 10) {
                    Button(action: {
                        self.viewModel.zeroWasPressed()
                    }, label: {
                        HButton(title: "0")
                    })
                    .frame(minWidth: geometry.size.width/2 - 22)
                    Button(action: {
                        self.viewModel.pointWasPressed()
                    }, label: {
                        HButton(title: ".")
                    })
                    Button(action: {
                        self.viewModel.equalWasPressed()
                    }, label: {
                        HButton(title: "=",
                                backgroundColor: Color.HOrange,
                                titleColor: Color.HBlack)
                    })
                }
                .frame(minHeight: geometry.size.height * Constants.rowHeight)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
                
            }
                
        }
        
    }
    
    func onKeyPress(_ key: String) {
        viewModel.keyWasPressed(key: key)
    }
}

fileprivate struct Constants {
    static let textHeight: CGFloat = 0.21
    static let rowHeight: CGFloat = 0.11
}

//#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
////        Group {
////            ContentView()
////                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
////        }
//    }
//}
//#endif
