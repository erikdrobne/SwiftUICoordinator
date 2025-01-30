//
//  TransitionProviderTests.swift
//
//
//  Created by Erik Drobne on 23. 10. 23.
//

import XCTest
@testable import SwiftUICoordinator

class TransitionProviderTests: XCTestCase {

    @MainActor
    func test_transitionProviderInitialization() {
        let transitions = [MockTransition(), MockTransition()]
        let sut = TransitionProvider(transitions: transitions)

        XCTAssertEqual(sut.transitions.count, transitions.count)
        XCTAssertNotNil(sut.transitions.first)
    }

    @MainActor
    func test_transitionDoesNotRetain() {
        let optionalTransition: MockTransition? = MockTransition()
        let transitions = [optionalTransition!]
        let sut = TransitionProvider(transitions: transitions)

        XCTAssertEqual(sut.transitions.count, transitions.count)
        DispatchQueue.main.async {
            XCTAssertTrue(sut.transitions.isEmpty)
        }
    }
}
