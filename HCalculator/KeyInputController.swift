//
//  KeyInputController.swift
//  LightCalculatorPlus
//
//  Created by Henry Javier Serrano Echeverria on 18/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

protocol KeyInput {
    func onKeyPress(_ key: String)
}

final class AppState: ObservableObject {
    var delegate: KeyInput?
}

final class KeyInputController<Content: View>: UIHostingController<Content> {

    private let state: AppState

    let keys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "+", "-", "/", "*", "=", "\u{8}", "\r", "\u{3}"]
    
    init(rootView: Content, state: AppState) {
        self.state = state
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func becomeFirstResponder() -> Bool {
        true
    }

    override var keyCommands: [UIKeyCommand]? {
        return keys.map {
            UIKeyCommand(input: $0,
                         modifierFlags: [],
                         action: #selector(keyPressed(_:)))
        }
    }

    @objc func keyPressed(_ sender: UIKeyCommand) {
        guard let key = sender.input else { return }
        state.delegate?.onKeyPress(key)
    }
}
