//
//  TransitionTests.swift
//
//
//  Created by Erik Drobne on 10. 10. 23.
//

import XCTest
import Foundation
@testable import SwiftUICoordinator

@MainActor
final class TransitionTests: XCTestCase {
    
    func test_registerTransitions() {
        let transition = MockTransition()
        let provider = TransitionProvider(transitions: [transition])
        let navigationController = NavigationController(transitionProvider: provider)
        
        guard let sut = navigationController.transitionProvider?.transitions[0].transition as? MockTransition else {
            XCTFail("Cannot cast to MockTransition.")
            return
        }
        
        XCTAssertEqual(sut, transition)
    }
}
