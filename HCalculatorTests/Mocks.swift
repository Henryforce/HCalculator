//
//  Mocks.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 19/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import SwiftUI
@testable import LightCalculatorPlus

struct MockView: View {
    
    @EnvironmentObject var state: AppState
    
    var body: some View {
        VStack { }
    }
    
}

final class MockKeyInput: KeyInput {
    var onKeyPressWasCalled = false
    func onKeyPress(_ key: String) {
        onKeyPressWasCalled = true
    }
}
