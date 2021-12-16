//
//  NumericPadView.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 16/12/21.
//  Copyright © 2021 Henry Serrano. All rights reserved.
//

import Foundation
import SwiftUI

struct NumericPadView: View, KeyInput {
    @EnvironmentObject var state: AppState
    @ObservedObject var viewModel: NumericPadViewModel
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .trailing, spacing: .zero) {
                
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
                .frame(height: geometry.size.height * Constants.rowHeight - Constants.paddingDifference)
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
                .frame(height: geometry.size.height * Constants.rowHeight - Constants.paddingDifference)
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
                .frame(height: geometry.size.height * Constants.rowHeight - Constants.paddingDifference)
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
                .frame(height: geometry.size.height * Constants.rowHeight - Constants.paddingDifference)
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
                .frame(height: geometry.size.height * Constants.rowHeight - Constants.paddingBottomDifference)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
                
            }.onAppear {
                self.state.delegate = self
            }
            
        }
    }
    
    func onKeyPress(_ key: String) {
        viewModel.keyWasPressed(key: key)
    }
}

fileprivate struct Constants {
    static let rowHeight: CGFloat = 0.2 // 0.11
    static let paddingDifference: CGFloat = 8
    static let paddingBottomDifference: CGFloat = 20
}
