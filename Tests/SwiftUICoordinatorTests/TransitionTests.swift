//
//  TransitionTests.swift
//
//
//  Created by Erik Drobne on 10. 10. 23.
//

import XCTest
import Foundation
@testable import SwiftUICoordinator

final class TransitionTests: XCTestCase {

    @MainActor
    func test_registerTransitions() {
        let transition = MockTransition()
        let provider = TransitionProvider(transitions: [transition])
        let transitionHandler = NavigationControllerTransitionHandler(provider: provider)
        let delegateProxy = NavigationControllerTransitionDelegate(transitionHandler: transitionHandler)

        guard let sut = delegateProxy.transitionHandler.provider.transitions[0] as? MockTransition else {
            XCTFail("Cannot cast to MockTransition.")
            return
        }

        XCTAssertEqual(sut, transition)
    }
}
