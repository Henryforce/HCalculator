//
//  KeyInputControllerTests.swift
//  LightCalculatorPlusTests
//
//  Created by Henry Javier Serrano Echeverria on 19/9/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import XCTest
import SwiftUI
@testable import LightCalculatorPlus

final class KeyInputControllerTests: XCTestCase {

    var sut: KeyInputController<MockView>!
    var view: MockView!
    var appState: AppState!
    var keyInput: MockKeyInput!
    
    override func setUpWithError() throws {
        keyInput = MockKeyInput()
        appState = AppState()
        appState.delegate = keyInput
        view = MockView()
        sut = KeyInputController(rootView: view,
                                 state: appState)
    }

    override func tearDownWithError() throws {
        keyInput = nil
        appState = nil
        view = nil
        sut = nil
    }

    func testKeyPressedCallsAppStateDelegate() throws {
        // Given
        let keyCommand = UIKeyCommand(input: "1",
                                      modifierFlags: [],
                                      action: #selector(keyPressed(_:)))
        
        // When
        sut.keyPressed(keyCommand)
        
        // Then
        XCTAssertTrue(keyInput.onKeyPressWasCalled)
    }
    
    func testKeysAndKeyCommandsAreSameSize() throws {
        // Given
        let keys = sut.keys
        let keyCommands = sut.keyCommands
        
        // Then
        XCTAssertEqual(keys.count, keyCommands?.count)
    }
    
    @objc private func keyPressed(_ sender: UIKeyCommand) { }

}
