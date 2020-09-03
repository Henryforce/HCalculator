//
//  ContentView.swift
//  HCalculator
//
//  Created by Henry Javier Serrano Echeverria on 3/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .trailing) {
                
                Text(self.viewModel.calculationResult)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(Color.HBlue)
                    .frame(minHeight: geometry.size.height * Constants.textHeight)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 4, trailing: 16))
                    .accessibility(identifier: "Result")
                
                HStack(spacing: 10) {
                    Button(action: {
                        self.viewModel.ACWasPressed()
                    }, label: {
                        HButton(title: "AC",
                                backgroundColor: Color.init(hex: "#eeeeeeff"),
                                titleColor: Color.init(hex: "#4f8a8bff"))
                    })
                    Button(action: {
                        self.viewModel.positiveNegativeWasPressed()
                    }, label: {
                        HButton(title: "+/-",
                                backgroundColor: Color.init(hex: "#eeeeeeff"),
                                titleColor: Color.init(hex: "#4f8a8bff"))
                    })
                    Button(action: {
                        self.viewModel.deleteWasPressed()
                    }, label: {
                        HButton(title: "<|",
                                backgroundColor: Color.init(hex: "#eeeeeeff"),
                                titleColor: Color.init(hex: "#4f8a8bff"))
                    })
                    Button(action: {
                        self.viewModel.divisionWasPressed()
                    }, label: {
                        Text("/")
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
}

fileprivate struct Constants {
    static let textHeight: CGFloat = 0.28
    static let rowHeight: CGFloat = 0.11
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        Group {
//            ContentView()
//                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
//        }
    }
}
#endif